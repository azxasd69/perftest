#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Проверка: клиентский код не вызывает синхронные файловые методы.

Повод: в модуле управляемого приложения вызывался КаталогВременныхФайлов().
В толстом и тонком клиенте на Windows это работает, а в клиенте, где платформа
запрещает синхронные методы (веб-клиент и подобные), падает с «Использование
синхронных методов на клиенте запрещено!» — и проверка форм/автопрогон падают
на записи маркера, а не на замере.

Правило: клиентская процедура не обращается к файлам и каталогам, к внешним
процессам и к диалогам выбора файла. Всё это живёт в серверных общих модулях
(например, ПерфОбслуживание.ЗаписатьВременныйФайл).

Коды возврата: 0 — чисто, 1 — найдены нарушения, 2 — сбой разбора.

Использование:
    python tools/check-client-io.py [--path src] [--json]
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

# Синхронные методы и конструкторы, запрещённые в клиентском контексте.
FORBIDDEN = [
    (r"\bНовый\s+ЗаписьТекста\b", "Новый ЗаписьТекста"),
    (r"\bНовый\s+ЧтениеТекста\b", "Новый ЧтениеТекста"),
    (r"\bКаталогВременныхФайлов\s*\(", "КаталогВременныхФайлов()"),
    (r"\bКаталогПрограммы\s*\(", "КаталогПрограммы()"),
    (r"\bНайтиФайлы\s*\(", "НайтиФайлы()"),
    (r"\bКопироватьФайл\s*\(", "КопироватьФайл()"),
    (r"\bПереместитьФайл\s*\(", "ПереместитьФайл()"),
    (r"\bУдалитьФайлы\s*\(", "УдалитьФайлы()"),
    (r"\bСоздатьКаталог\s*\(", "СоздатьКаталог()"),
    (r"\bЗапуститьПриложение\s*\(", "ЗапуститьПриложение()"),
    (r"\bПоместитьФайл\s*\(", "ПоместитьФайл()"),
    (r"\bПолучитьФайл\s*\(", "ПолучитьФайл()"),
    (r"\bОткрытьФайл\s*\(", "ОткрытьФайл()"),
    (r"\bОткрытьФайлДляЧтения\s*\(", "ОткрытьФайлДляЧтения()"),
    (r"\bНачатьПомещениеФайла\s*\(", "НачатьПомещениеФайла()"),
    (r"\bНачатьПолучениеФайла\s*\(", "НачатьПолучениеФайла()"),
    (r"\bДиалогВыбораФайла\s*\(", "ДиалогВыбораФайла()"),
]
PATTERNS = [(re.compile(p, re.IGNORECASE), label) for p, label in FORBIDDEN]

PROC_RE = re.compile(r"^\s*(?:Процедура|Функция)\s+([A-Za-zА-Яа-яЁё_0-9]+)\s*\(", re.IGNORECASE)
DIRECTIVE_RE = re.compile(r"^\s*&([A-Za-zА-Яа-яЁё]+)")

# Директивы компиляции: где исполняется код.
CLIENT_DIRECTIVES = {"наклиенте", "наклиентенасерверебезконтекста"}
SERVER_DIRECTIVES = {"насервере", "насерверебезконтекста"}


def strip_comment(line: str) -> str:
    """Убирает строчный комментарий //, не трогая содержимое строковых литералов."""
    out, quote = [], None
    i = 0
    while i < len(line):
        ch = line[i]
        if quote:
            if ch == quote:
                # '' внутри строки — экранированная кавычка
                if i + 1 < len(line) and line[i + 1] == quote:
                    out.append(ch + quote)
                    i += 2
                    continue
                quote = None
            out.append(ch)
        else:
            if ch in "\"'":
                quote = ch
                out.append(ch)
            elif ch == "/" and i + 1 < len(line) and line[i + 1] == "/":
                break
            else:
                out.append(ch)
        i += 1
    return "".join(out)


def common_module_context(xml_path: Path) -> str:
    """'client', 'server' или 'both' по флагам общего модуля."""
    try:
        text = xml_path.read_text(encoding="utf-8-sig")
    except OSError:
        return "both"

    def flag(tag: str) -> bool:
        m = re.search(rf"<{tag}>(true|false)</{tag}>", text)
        return bool(m and m.group(1) == "true")

    client = any(
        flag(t)
        for t in (
            "ClientManagedApplication",
            "ClientOrdinaryApplication",
            "Client",
        )
    )
    server = flag("Server") or flag("ExternalConnection")
    if client and server:
        return "both"
    if client:
        return "client"
    if server:
        return "server"
    return "both"


def scan_file(path: Path, root: Path) -> list[dict]:
    rel = path.relative_to(root).as_posix()
    is_form_module = "/Forms/" in rel or "/Ext/Form/" in f"/{rel}"
    is_app_module = rel.lower().endswith("ext/managedapplicationmodule.bsl")

    context: str
    if is_form_module:
        context = "form"  # решается директивой у процедуры
    elif is_app_module:
        context = "client"  # модуль приложения исполняется на клиенте
    elif "/CommonModules/" in f"/{rel}" and path.parent.name == "Ext":
        name = path.parent.parent.name
        xml_file = path.parent.parent.parent / f"{name}.xml"
        context = common_module_context(xml_file) if xml_file.exists() else "both"
    else:
        context = "server"  # модули объектов, наборов записей и т. п.

    lines = path.read_text(encoding="utf-8-sig").splitlines()
    problems: list[dict] = []
    directive = None
    proc = "—"
    in_server_region = 0  # глубина #Если Сервер

    for number, raw in enumerate(lines, start=1):
        stripped = raw.strip()
        low = stripped.lower()

        if low.startswith("#если") and "сервер" in low:
            in_server_region += 1
        elif low.startswith("#конецесли") and in_server_region:
            in_server_region -= 1

        m = DIRECTIVE_RE.match(stripped)
        if m:
            directive = m.group(1).lower()
            continue
        m = PROC_RE.match(stripped)
        if m:
            proc = m.group(1)
            continue

        code = strip_comment(raw)
        if not code.strip() or code.strip().startswith("//"):
            continue

        if context == "client":
            client_code = True
        elif context == "server":
            client_code = False
        elif context == "form":
            if directive in SERVER_DIRECTIVES:
                client_code = False
            elif directive in CLIENT_DIRECTIVES:
                client_code = True
            else:
                client_code = True  # без директивы — клиент
        else:  # both — код может исполняться на клиенте
            client_code = True

        if in_server_region:
            client_code = False

        if not client_code:
            continue

        for pattern, label in PATTERNS:
            if pattern.search(code):
                problems.append(
                    {
                        "file": rel,
                        "line": number,
                        "procedure": proc,
                        "directive": f"&{directive}" if directive else "—",
                        "call": label,
                        "code": stripped[:120],
                    }
                )
                break
    return problems


def main() -> int:
    # Windows-консоль по умолчанию в cp866: русские имена файлов иначе нечитаемы.
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except (AttributeError, ValueError):
            pass

    parser = argparse.ArgumentParser(description="Клиентский код не трогает файлы")
    parser.add_argument("--path", default="src", help="каталог выгрузки конфигурации")
    parser.add_argument("--json", action="store_true", help="вывод в JSON")
    args = parser.parse_args()

    root = Path(args.path)
    if not root.exists():
        print(f"[fail] каталог не найден: {root}", file=sys.stderr)
        return 2

    files = sorted(root.rglob("*.bsl"))
    if not files:
        print(f"[fail] в {root} нет файлов *.bsl", file=sys.stderr)
        return 2

    problems: list[dict] = []
    for path in files:
        try:
            problems.extend(scan_file(path, root.parent))
        except Exception as exc:  # разбор не должен падать молча
            print(f"[fail] {path}: {exc}", file=sys.stderr)
            return 2

    if args.json:
        print(json.dumps(problems, ensure_ascii=False, indent=2))
    else:
        if problems:
            print(f"[fail] найдено {len(problems)} обращений к файлам в клиентском коде:")
            for p in problems:
                print(f"  {p['file']}:{p['line']}  {p['directive']:12} {p['procedure']}  {p['call']}")
                print(f"      {p['code']}")
            print("\nВынесите операцию в серверный общий модуль:")
            print("  ПерфОбслуживание.ЗаписатьТекстовыйФайл / ЗаписатьВременныйФайл")
        else:
            print(f"[ok]   клиентский код не трогает файлы: файлов {len(files)}, нарушений 0")

    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
