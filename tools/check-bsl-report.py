"""Разбор JSON-отчёта BSL Language Server: падаем только на ошибках.

Отчёт создаётся так (см. .github/workflows/ci.yml):

    java -jar bsl-language-server.jar analyze -s src -o build/bsl -r json -q

Предупреждения и информационные замечания печатаются, но сборку не валят:
в конфигурации есть осознанно принятые отклонения (запросы в цикле внутри
сценариев замера), они описаны в docs/Проверки.md и docs/EDT_прогон.md.

Код возврата: 0 - ошибок нет, 1 - есть ERROR, 2 - отчёт не найден.
"""
import json
import sys
import pathlib

ERROR_MARKS = {'error', 'ошибка', 'critical', 'критическая'}


def diagnostics_of(node, acc):
    if isinstance(node, dict):
        for key, value in node.items():
            if key == 'diagnostics' and isinstance(value, list):
                acc.extend(value)
            else:
                diagnostics_of(value, acc)
    elif isinstance(node, list):
        for item in node:
            diagnostics_of(item, acc)


def main():
    if len(sys.argv) < 2:
        print('usage: check-bsl-report.py <каталог отчёта>')
        return 2
    out_dir = pathlib.Path(sys.argv[1])
    reports = sorted(out_dir.glob('*.json')) if out_dir.is_dir() else []
    if not reports:
        print(f'[fail] отчёт не найден в {out_dir}')
        return 2

    total = errors = warnings = 0
    error_items = []
    for report in reports:
        try:
            data = json.loads(report.read_text(encoding='utf-8-sig'))
        except json.JSONDecodeError as exc:
            print(f'[fail] {report.name}: не JSON ({exc})')
            return 2
        found = []
        diagnostics_of(data, found)
        for diag in found:
            severity = str(diag.get('severity', '')).strip().lower()
            if not severity:
                continue
            total += 1
            if severity in ERROR_MARKS:
                errors += 1
                error_items.append(diag)
            else:
                warnings += 1

    for diag in error_items:
        code = diag.get('code') or diag.get('diagnosticCode') or '?'
        msg = diag.get('message', '').splitlines()[0] if diag.get('message') else ''
        loc = diag.get('file') or diag.get('uri') or ''
        print(f'   ERROR {code}: {msg[:160]}  {str(loc)[-90:]}')

    print(f'[{"ok" if not errors else "fail"}]   замечаний {total}: ошибок {errors}, прочих {warnings}')
    return 0 if errors == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
