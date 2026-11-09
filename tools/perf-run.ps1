<#
.SYNOPSIS
    Автономный прогон тестов производительности «ПерфТест» через указанный bin 1С.

.DESCRIPTION
    Запускает 1cv8.exe (ENTERPRISE, файловая база d:\InfoBasePerf) с параметром
    /C «ПерфАвтоПрогон;<CSV>». Сеанс сам выполняет все 11 сценариев (3 повтора),
    пишет CSV и закрывается. Код возврата: 0 - успех и CSV создан, 1 - сбой.

.PARAMETER Bin
    Путь к 1cv8.exe. По умолчанию - вендорская 8.3.27.2342.

.PARAMETER Base
    Каталог файловой ИБ. По умолчанию d:\InfoBasePerf.

.PARAMETER Csv
    Файл результата. По умолчанию <bin-каталог>\..\perf-results\<метка>.csv в workspace.

.PARAMETER Chunks
    Число чанков прогона (0 = по умолчанию 10). Передаётся третьим сегментом
    параметра запуска; 1 = монолитный замер без сообщений прогресса.

.EXAMPLE
    pwsh -File tools\perf-run.ps1 -Bin '%USERPROFILE%\tools\1c-8327-libs-test\1cv8.exe'
#>
[CmdletBinding()]
param(
    [string]$Bin = 'C:\Program Files (x86)\1cv8\8.3.27.2342\bin\1cv8.exe',
    [string]$Base = 'd:\InfoBasePerf',
    [string]$Csv,
    [int]$Chunks = 0
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Bin)) { Write-Error "Не найден 1cv8.exe: $Bin"; exit 2 }
if (-not (Test-Path -LiteralPath $Base)) { Write-Error "Не найдена база: $Base"; exit 2 }

# окружение для лицензий (в агентском шелле переменные пустые)
$env:LOCALAPPDATA = Join-Path $env:USERPROFILE 'AppData\Local'
$env:APPDATA = Join-Path $env:USERPROFILE 'AppData\Roaming'
$env:TEMP = Join-Path $env:LOCALAPPDATA 'Temp'

if (-not $Csv) {
    $stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    $binDir = Split-Path $Bin -Parent
    $tag = $binDir | Split-Path -Leaf
    if ($tag -eq 'bin') { $tag = (Split-Path (Split-Path $binDir -Parent) -Leaf) }
    $Csv = Join-Path (Get-Location) ('out\perf\' + $stamp + '_' + ($tag -replace '[^\w\.-]', '_') + '.csv')
}
$outDir = Split-Path $Csv -Parent
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

$log = Join-Path ([IO.Path]::GetTempPath()) ('perf-run-' + [guid]::NewGuid().ToString('N') + '.log')

# файловая база допускает сеансы только одной версии платформы одновременно;
# ждём завершения чужих сеансов с этой базой (до 5 минут)
$deadline = (Get-Date).AddMinutes(5)
while ((Get-Date) -lt $deadline) {
    $busy = Get-CimInstance Win32_Process -Filter "Name like '1cv8%'" |
        Where-Object { $_.CommandLine -and $_.CommandLine -like ('*' + $Base + '*') }
    if (-not $busy) { break }
    Start-Sleep -Seconds 5
}
$busy = Get-CimInstance Win32_Process -Filter "Name like '1cv8%'" |
    Where-Object { $_.CommandLine -and $_.CommandLine -like ('*' + $Base + '*') }
if ($busy) { Write-Error "База занята активными сеансами: $($busy.ProcessId -join ', ')"; exit 2 }

$autoParam = 'ПерфАвтоПрогон;' + $Csv
if ($Chunks -gt 0) { $autoParam = $autoParam + ';' + $Chunks }
$args = 'ENTERPRISE /F"' + $Base + '" /C "' + $autoParam + '" /DisableStartupMessages /DisableStartupDialogs /Out "' + $log + '"'

$sw = [Diagnostics.Stopwatch]::StartNew()
$proc = Start-Process -FilePath $Bin -ArgumentList $args -PassThru -Wait -WindowStyle Hidden
$sw.Stop()

if (Test-Path -LiteralPath $log) {
    $text = Get-Content -LiteralPath $log -Encoding UTF8 -Raw
    if ($text -and $text.Trim()) { $text.Trim() }
    Remove-Item -LiteralPath $log -Force -ErrorAction SilentlyContinue
}

"---"
"bin: $Bin"
"база: $Base"
"время: $([int]$sw.Elapsed.TotalSeconds) с; код возврата: $($proc.ExitCode)"
if (Test-Path -LiteralPath $Csv) {
    "CSV: $Csv (" + (Get-Content -LiteralPath $Csv -Encoding UTF8).Count + " строк)"
    exit 0
}
"CSV не создан"
exit 1
