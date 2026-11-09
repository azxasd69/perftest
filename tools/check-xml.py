"""Проверка выгрузки конфигурации: XML корректен, кодировка и EOL соответствуют эталону.

Эталон проекта: каждый *.xml и *.bsl — UTF-8 с BOM и только CRLF. Так пишет
платформа, так хранится в git (см. .gitattributes). Отклонение означает, что
файл правился вручную и выгрузку надо нормализовать.

Код возврата: 0 - чисто, 1 - есть нарушения.
"""
import sys
import pathlib
import xml.etree.ElementTree as ET

root = pathlib.Path(__file__).resolve().parent.parent
TARGETS = [root / 'src', root / 'ext']
BOM = b'\xef\xbb\xbf'

problems = []
checked = 0

for target in TARGETS:
    for path in sorted(target.rglob('*')):
        if not path.is_file() or path.suffix.lower() not in {'.xml', '.bsl'}:
            continue
        checked += 1
        rel = path.relative_to(root)
        data = path.read_bytes()
        if not data.startswith(BOM):
            problems.append(f'{rel}: нет BOM')
        try:
            text = data.decode('utf-8-sig')
        except UnicodeDecodeError as exc:
            problems.append(f'{rel}: не UTF-8 ({exc})')
            continue
        crlf = text.count('\r\n')
        lf = text.count('\n')
        if crlf != lf:
            problems.append(f'{rel}: окончания строк не CRLF (CRLF {crlf}, всего LF {lf})')
        if path.suffix.lower() == '.xml':
            try:
                ET.fromstring(text)
            except ET.ParseError as exc:
                problems.append(f'{rel}: XML не разбирается ({exc})')

if problems:
    print(f'[fail] проверено {checked} файлов, нарушений {len(problems)}')
    for p in problems[:50]:
        print('   ' + p)
    if len(problems) > 50:
        print(f'   ... ещё {len(problems) - 50}')
    sys.exit(1)

print(f'[ok]   {checked} файлов: XML корректен, BOM и CRLF на месте')
