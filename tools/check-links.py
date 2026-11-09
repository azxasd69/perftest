"""Проверка относительных ссылок в markdown: файл по ссылке должен существовать.

Ловит типовой регресс при перестройке репозитория: документ переехал в docs/,
а ссылка на него осталась старой. Внешние ссылки (http, mailto, якоря) не
проверяются — для них нужен сетевой доступ.

Код возврата: 0 - битых ссылок нет, 1 - есть.
"""
import re
import sys
import pathlib
from urllib.parse import unquote

root = pathlib.Path(__file__).resolve().parent.parent
LINK = re.compile(r'\[[^\]]*\]\(([^)]+)\)')
SKIP_PREFIX = ('http://', 'https://', 'mailto:', '#', 'tel:')

broken = []
checked = 0

for md in sorted(root.rglob('*.md')):
    rel_md = md.relative_to(root)
    if any(part in {'.git', 'node_modules'} for part in rel_md.parts):
        continue
    text = md.read_text(encoding='utf-8-sig')
    for target in LINK.findall(text):
        target = target.strip().split(' ')[0]
        if not target or target.startswith(SKIP_PREFIX):
            continue
        path_part = unquote(target.split('#')[0])
        if not path_part:
            continue
        checked += 1
        resolved = (md.parent / path_part).resolve()
        if not resolved.exists():
            broken.append(f'{rel_md}: {target}')

if broken:
    print(f'[fail] проверено ссылок {checked}, битых {len(broken)}')
    for item in broken:
        print('   ' + item)
    sys.exit(1)

print(f'[ok]   ссылок проверено {checked}, битых нет')
