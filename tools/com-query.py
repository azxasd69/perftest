#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Read-only запросы к ИБ 1С через COM-коннектор V83.COMConnector.

Запускать ТОЛЬКО 32-битным Python: comcntr.dll 1С собрана как x86, в 64-битном
процессе класс не зарегистрирован (REGDB_E_CLASSNOTREG).
    D:\\dev\\pysite32\\python.exe tools\\1c\\com-query.py --base d:\\InfoBase \\
        --query "ВЫБРАТЬ Код, Наименование ИЗ Справочник.Номенклатура"
Удобнее через обёртку: pwsh -File tools\\1c\\com-query.ps1 -Base ... -Query ...

Особенность, проверенная на 1С 8.3.27 (см. tools\\1c\\README-com.md):
объекты, которые 1С отдаёт через IDispatch, не имеют TypeInfo, поэтому
win32com в late binding видит только члены, зарегистрированные 1С в своей
дисп-таблице. Коллекции и методы результата запроса (Колонки, Выгрузить,
Получить, Количество) доступны, а построчный курсор — нет; поэтому строки
читаются через РезультатЗапроса.Выгрузить() -> ТаблицаЗначений.

Аутентификация ИБ по умолчанию (file-режим) не требуется; для базы с
пользователями имя задаётся --user, строка аутентификации — переменной
окружения ONEC_CONNINFO (например  Usr="admin";Pwd="..."  — без кавычек поле
подставляется в строку соединения как есть).
"""

import argparse
import json
import os
import struct
import sys

BITS = struct.calcsize("P") * 8


def fail(msg, code=2):
    print(json.dumps({"ok": False, "error": msg}, ensure_ascii=False))
    sys.exit(code)


def unwrap(exc):
    """Описание ошибки 1С лежит во втором элементе com_error (excepinfo)."""
    try:
        info = exc.args[2] if len(exc.args) > 2 else None
        if isinstance(info, tuple) and len(info) > 2 and info[2]:
            return str(info[2]).replace("\n", " ")
    except Exception:
        pass
    return str(exc)


def cell(value):
    if value is None:
        return None
    if isinstance(value, (str, int, float, bool)):
        return value
    iso = getattr(value, "ISOFormat", None)
    if callable(iso):
        try:
            return iso(" ")
        except Exception:
            pass
    try:
        return str(value)
    except Exception:
        return repr(value)


def call(obj, name, kind=None, *args):
    """Вызов члена по имени через IDispatch (обходит неполный gencache)."""
    import pythoncom

    disp = obj if hasattr(obj, "GetIDsOfNames") else obj._oleobj_
    try:
        dispid = disp.GetIDsOfNames(name)
    except Exception as exc:
        raise RuntimeError("%s: %s" % (name, unwrap(exc)))
    return disp.Invoke(dispid, 0, kind or pythoncom.DISPATCH_METHOD, 1, *args)


def prop(obj, name):
    import pythoncom

    return call(obj, name, pythoncom.DISPATCH_PROPERTYGET)


def put(obj, name, value):
    import pythoncom

    disp = obj if hasattr(obj, "GetIDsOfNames") else obj._oleobj_
    return disp.Invoke(disp.GetIDsOfNames(name), 0, pythoncom.DISPATCH_PROPERTYPUT, 1, value)


def main():
    ap = argparse.ArgumentParser(description="Read-only запрос к 1С через COM-коннектор")
    ap.add_argument("--base", required=True, help="каталог файловой ИБ (1Cv8.1CD) или строка File=...")
    ap.add_argument("--query", help="текст запроса (обязателен, если нет --info)")
    ap.add_argument("--user", default="", help="пользователь ИБ")
    ap.add_argument("--max-rows", type=int, default=100, help="сколько строк вывести (по умолчанию 100)")
    ap.add_argument("--info", action="store_true", help="только сведения о конфигурации")
    ap.add_argument("--progid", default="V83.COMConnector")
    ap.add_argument("--raw", action="store_true", help="не проверять, что запрос читающий")
    ap.add_argument("--table", action="store_true", help="вывести таблицу в консоль (TSV) вместо JSON")
    args = ap.parse_args()

    if BITS == 64:
        fail(
            "запущен 64-битный Python: comcntr.dll 1С зарегистрирована только как x86. "
            "Используйте D:\\dev\\pysite32\\python.exe или обёртку tools\\1c\\com-query.ps1",
            code=3,
        )

    try:
        import win32com.client as win32
    except Exception as exc:
        fail("pywin32 не найден: %s" % exc, code=3)

    auth = os.environ.get("ONEC_CONNINFO", "")
    base = args.base
    if base.startswith("File="):
        conn_str = base if base.rstrip().endswith(";") else base + ";"
    else:
        conn_str = 'File="%s";Usr="%s";' % (base, args.user) + auth

    try:
        connector = win32.Dispatch(args.progid)
    except Exception as exc:
        fail("не удалось создать %s: %s" % (args.progid, unwrap(exc)), code=4)
    try:
        conn = connector.Connect(conn_str)
    except Exception as exc:
        fail("Connect: %s" % unwrap(exc), code=5)
    conn = conn._oleobj_ if hasattr(conn, "_oleobj_") else conn

    result = {"ok": True, "base": base, "progid": args.progid, "bits": BITS}

    try:
        md = prop(conn, "Метаданные")
        result["configuration"] = str(prop(md, "Имя"))
    except Exception:
        md = None

    if args.info:
        if md is not None:
            counts = {}
            for name in (
                "Справочники", "Документы", "РегистрыСведений", "РегистрыНакопления",
                "РегистрыБухгалтерии", "ПланыВидовХарактеристик", "Отчеты", "Обработки",
            ):
                try:
                    counts[name] = call(prop(md, name), "Количество")
                except Exception:
                    pass
            result["metadata_counts"] = counts
        print(json.dumps(result, ensure_ascii=False, indent=1))
        return

    text = (args.query or "").strip()
    if not text:
        fail("не задан --query", code=2)
    lowered = text.lstrip().lower()
    if not args.raw and not lowered.startswith(("выбрать", "select")):
        fail("разрешены только читающие запросы (ВЫБРАТЬ ...); для остального --raw", code=2)

    try:
        query = call(conn, "NewObject", None, "Запрос")
        put(query, "Текст", text)
        raw_result = call(query, "Выполнить")
        table = call(raw_result, "Выгрузить")
        table = table if hasattr(table, "GetIDsOfNames") else table._oleobj_
        total = call(table, "Количество")
        columns_coll = prop(table, "Колонки")
        columns = [
            str(prop(call(columns_coll, "Получить", None, i), "Имя"))
            for i in range(call(columns_coll, "Количество"))
        ]
    except Exception as exc:
        fail("запрос не выполнен: %s" % unwrap(exc), code=7)

    rows = []
    try:
        for i in range(min(int(total), args.max_rows)):
            row_obj = call(table, "Получить", None, i)
            row = {}
            for name in columns:
                try:
                    row[name] = cell(prop(row_obj, name))
                except Exception:
                    row[name] = cell(call(row_obj, name))
            rows.append(row)
    except Exception as exc:
        fail("ошибка чтения строк: %s" % unwrap(exc), code=8)

    result.update({
        "columns": columns,
        "rows": rows,
        "row_count": len(rows),
        "total_rows": int(total),
        "truncated": int(total) > len(rows),
    })

    if args.table:
        print("\t".join(columns))
        for row in rows:
            print("\t".join("" if row[c] is None else str(row[c]) for c in columns))
        return
    print(json.dumps(result, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
