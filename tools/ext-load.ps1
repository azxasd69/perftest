# Загрузка расширения конфигурации в файловую ИБ и применение изменений.
#
# Зачем: оформление PerfTest (палитра, стиль платформы) живёт в расширении
# ext\PerfStyle. При пересоздании базы (recreate) расширение не попадает в неё
# автоматически, и приложение выглядит "не покрашенным". Этот скрипт закрывает шаг.
#
# Использование:
#   pwsh -NoProfile -File tools\ext-load.ps1 -Base d:\InfoBasePerf -Ext ext\PerfStyle -Name PerfStyle
param(
    [string]$Base = 'd:\InfoBasePerf',
    [string]$Ext = 'ext\PerfStyle',
    [string]$Name = 'PerfStyle',
    [string]$PlatformVersion = '8.3.27.2342'
)

$ErrorActionPreference = 'Stop'

# Платформа не видит лицензию без этих переменных в урезанном агентском шелле.
if (-not $env:LOCALAPPDATA) { $env:LOCALAPPDATA = "$env:USERPROFILE\AppData\Local" }
if (-not $env:APPDATA) { $env:APPDATA = "$env:USERPROFILE\AppData\Roaming" }
if (-not $env:TEMP) { $env:TEMP = "$env:LOCALAPPDATA\Temp" }

$exe = "C:\Program Files (x86)\1cv8\$PlatformVersion\bin\1cv8.exe"
if (-not (Test-Path -LiteralPath $exe)) { throw "нет платформы: $exe" }
if (-not (Test-Path -LiteralPath $Ext)) { throw "нет каталога расширения: $Ext" }

$extPath = (Resolve-Path -LiteralPath $Ext).Path

# Шаг 1: загрузка расширения из файлов.
& $exe DESIGNER "/F$Base" /LoadConfigFromFiles $extPath -Extension $Name /DisableStartupMessages /DisableStartupDialogs
$rc1 = $LASTEXITCODE
Start-Sleep -Seconds 2

# Шаг 2: применение изменений (отдельной командой: совмещение даёт ошибку параметров).
& $exe DESIGNER "/F$Base" /UpdateDBCfg -Extension $Name /DisableStartupMessages /DisableStartupDialogs
$rc2 = $LASTEXITCODE

"Расширение: $Name; база: $Base; load=$rc1 update=$rc2"
exit ([int]($rc1 -ne 0) -bor ([int]($rc2 -ne 0) -shl 1))
