"""Проверка согласованности версии.

Единственный источник — <Version> в выгрузке конфигурации. Шапка README и
первая запись CHANGELOG обязаны совпадать с ним: именно этот рассинхрон
(в документах 1.22-1.37 при фактических 1.42) был найден при подготовке
репозитория к публикации.

Код возврата: 0 - согласовано, 1 - расхождение, 2 - не удалось прочитать.
"""
import re
import sys
import pathlib

root = pathlib.Path(__file__).resolve().parent.parent


def read_version():
    cfg = root / 'src' / 'Configuration.xml'
    text = cfg.read_text(encoding='utf-8-sig')
    m = re.search(r'<Version>([^<]+)</Version>', text)
    if not m:
        print(f'[fail] в {cfg} нет тега <Version>')
        sys.exit(2)
    return m.group(1).strip()


def main():
    version = read_version()
    errors = []

    readme = (root / 'README.md').read_text(encoding='utf-8')
    if f'версия-{version}-' not in readme:
        errors.append(f'README.md: значок версии не содержит {version}')

    changelog = (root / 'CHANGELOG.md').read_text(encoding='utf-8')
    m = re.search(r'^## \[([^\]]+)\]', changelog, re.MULTILINE)
    if not m:
        errors.append('CHANGELOG.md: нет ни одной записи вида "## [версия]"')
    elif m.group(1) != version:
        errors.append(f'CHANGELOG.md: последняя запись {m.group(1)}, в выгрузке {version}')

    if errors:
        print(f'[fail] выгрузка: {version}')
        for e in errors:
            print('   ' + e)
        return 1
    print(f'[ok]   версия согласована: {version} (выгрузка, README, CHANGELOG)')
    return 0


if __name__ == '__main__':
    sys.exit(main())
