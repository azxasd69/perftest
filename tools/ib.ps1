<#
.SYNOPSIS
    Headless-операции с файловой информационной базой 1С через CLI 1cv8.exe.

.DESCRIPTION
    Заменяет ibcmd (в сборке 8.5.4.1306 его нет) там, где нужны операции с файловой ИБ:
    создать базу, выгрузить конфигурацию в XML, загрузить XML обратно, проверить модули.

    Скрипт сам выставляет LOCALAPPDATA/APPDATA/TEMP (в агентском шелле они пустые —
    платформа ищет по ним лицензии), подставляет платформу из .dev.env (PLATFORM_PATH)
    или берёт самую свежую из C:\Program Files (x86)\1cv8, пишет лог и печатает его.

    Код возврата: код 1cv8.exe (0 — успех), 2 — не найдена платформа/каталог.

.PARAMETER Action
    create — создать файловую ИБ; dump — выгрузить конфигурацию в XML;
    load — загрузить XML в базу; check — проверить модули (/CheckModules).

.PARAMETER Base
    Путь к каталогу файловой ИБ.

.PARAMETER Dir
    Каталог XML для dump/load.

.EXAMPLE
    .\tools\ib.ps1 -Action create -Base scratch\mybase

.EXAMPLE
    .\tools\ib.ps1 -Action dump -Base scratch\mybase -Dir scratch\mybase-xml
#>
[CmdletBinding()]
param(
    [ValidateSet('create', 'recreate', 'dump', 'load', 'check')]
    [string]$Action = 'check',

    [Parameter(Mandatory = $true)]
    [string]$Base,

    [string]$Dir,

    [string]$PlatformPath,

    [string]$PlatformVersion,

    # Не нормализовать выгрузку после dump (по умолчанию нормализуется: BOM, CRLF, порядок узлов).
    [switch]$NoNormalize,

    [int]$TimeoutSec = 900
)

$ErrorActionPreference = 'Stop'

# --- окружение: без этих переменных платформа не находит лицензии -------------
$env:LOCALAPPDATA = Join-Path $env:USERPROFILE 'AppData\Local'
$env:APPDATA = Join-Path $env:USERPROFILE 'AppData\Roaming'
$env:TEMP = Join-Path $env:LOCALAPPDATA 'Temp'

function Resolve-Platform {
    param([string]$Explicit, [string]$Version)
    $root = 'C:\Program Files (x86)\1cv8'
    if ($Version) {
        $dir = Join-Path $root $Version
        $exe = Join-Path $dir 'bin\1cv8.exe'
        if (Test-Path -LiteralPath $exe) { return $exe }
        throw "Версия $Version не найдена в $root"
    }
    if ($Explicit) {
        $exe = Join-Path $Explicit 'bin\1cv8.exe'
        if (Test-Path -LiteralPath $exe) { return $exe }
        throw "Не найден 1cv8.exe в $Explicit"
    }
    $devEnv = Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) '1c\project\.dev.env'
    if (Test-Path -LiteralPath $devEnv) {
        $line = Get-Content -LiteralPath $devEnv -Encoding UTF8 | Where-Object { $_ -match '^PLATFORM_PATH=' } | Select-Object -First 1
        if ($line) {
            $path = ($line -split '=', 2)[1].Trim()
            if ($path) {
                $exe = Join-Path $path 'bin\1cv8.exe'
                if (Test-Path -LiteralPath $exe) { return $exe }
            }
        }
    }
    $root = 'C:\Program Files (x86)\1cv8'
    if (Test-Path -LiteralPath $root) {
        $ver = Get-ChildItem -LiteralPath $root -Directory |
            Where-Object { $_.Name -match '^\d+\.\d+\.\d+\.\d+$' } |
            Sort-Object { [version]$_.Name } -Descending | Select-Object -First 1
        if ($ver) {
            $exe = Join-Path $ver.FullName 'bin\1cv8.exe'
            if (Test-Path -LiteralPath $exe) { return $exe }
        }
    }
    throw 'Платформа 1С не найдена: задайте -PlatformPath или PLATFORM_PATH в .dev.env'
}

$exe = Resolve-Platform -Explicit $PlatformPath -Version $PlatformVersion
$basePath = [IO.Path]::GetFullPath($Base, (Get-Location).ProviderPath)
$logDir = Join-Path ([IO.Path]::GetTempPath()) ('1c-ib-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
$log = Join-Path $logDir '1cv8.log'

$argList = switch ($Action) {
    'create' {
        if (-not (Test-Path -LiteralPath $basePath)) { New-Item -ItemType Directory -Path $basePath -Force | Out-Null }
        @('CREATEINFOBASE', "File=`"$basePath`"")
    }
    'dump' {
        if (-not $Dir) { throw 'Для -Action dump нужен -Dir <каталог XML>' }
        $xml = [IO.Path]::GetFullPath($Dir, (Get-Location).ProviderPath)
        if (-not (Test-Path -LiteralPath $xml)) { New-Item -ItemType Directory -Path $xml -Force | Out-Null }
        @('DESIGNER', "/F`"$basePath`"", '/DumpConfigToFiles', "`"$xml`"")
    }
    'load' {
        if (-not $Dir) { throw 'Для -Action load нужен -Dir <каталог XML>' }
        $xml = [IO.Path]::GetFullPath($Dir, (Get-Location).ProviderPath)
        @('DESIGNER', "/F`"$basePath`"", '/LoadConfigFromFiles', "`"$xml`"", '/UpdateDBCfg')
    }
    'recreate' {
        # Пустая ИБ: сначала создание, загрузка конфигурации - отдельным вызовом ниже
        # (в одной командной строке CREATEINFOBASE+Load платформа не всегда применяет).
        if (-not $Dir) { throw 'Для -Action recreate нужен -Dir <каталог XML>' }
        if (Test-Path -LiteralPath $basePath) { Remove-Item -LiteralPath $basePath -Recurse -Force }
        New-Item -ItemType Directory -Path $basePath -Force | Out-Null
        @('CREATEINFOBASE', "File=`"$basePath`"")
    }
    'check' {
        @('DESIGNER', "/F`"$basePath`"", '/CheckModules')
    }
}
$argList += @('/DisableStartupMessages', '/DisableStartupDialogs', "/Out `"$log`"")

Write-Verbose "Выполняется: $exe $($argList -join ' ')"
$proc = Start-Process -FilePath $exe -ArgumentList $argList -PassThru -Wait -WindowStyle Hidden
$code = $proc.ExitCode

if (Test-Path -LiteralPath $log) {
    $text = Get-Content -LiteralPath $log -Encoding UTF8 -Raw
    if ($text -and $text.Trim()) { $text.Trim() }
    else { '(лог пуст — вероятно, успех)' }
}
else { '(лог не создан)' }

"---"
"Действие: $Action; база: $basePath; код возврата: $code"
if ($Action -eq 'recreate' -and $code -eq 0) {
    $xml = [IO.Path]::GetFullPath($Dir, (Get-Location).ProviderPath)
    $loadArgs = @('DESIGNER', "/F`"$basePath`"", '/LoadConfigFromFiles', "`"$xml`"", '/UpdateDBCfg',
        '/DisableStartupMessages', '/DisableStartupDialogs', "/Out `"$log`"")
    Write-Host '--- загрузка конфигурации в пустую базу ---'
    $proc2 = Start-Process -FilePath $exe -ArgumentList $loadArgs -PassThru -Wait -WindowStyle Hidden
    $code = $proc2.ExitCode
    if (Test-Path -LiteralPath $log) {
        $text2 = Get-Content -LiteralPath $log -Encoding UTF8 -Raw
        if ($text2 -and $text2.Trim()) { $text2.Trim() }
    }
}

if (Test-Path -LiteralPath $logDir) { Remove-Item -LiteralPath $logDir -Recurse -Force -ErrorAction SilentlyContinue }

# Нормализация выгрузки: платформа пишет служебные узлы в произвольном порядке,
# из-за чего git diff после работы в конфигураторе показывает шум.
if (($Action -eq 'dump' -or $Action -eq 'recreate') -and $code -eq 0 -and -not $NoNormalize) {
    $normalizer = Join-Path $PSScriptRoot 'normalize-dump.ps1'
    if (Test-Path -LiteralPath $normalizer) {
        Write-Host '--- нормализация выгрузки (BOM, CRLF, порядок служебных узлов) ---'
        & pwsh -NoProfile -File $normalizer -Path $Dir -Apply | Select-Object -Last 2
    }
}

# Предупреждение: формат выгрузки новее, чем понимает 1C:EDT
if ($Action -eq 'dump' -and $code -eq 0) {
    $ver = Split-Path (Split-Path $exe -Parent) -Parent | Split-Path -Leaf
    $v = $null
    if ([version]::TryParse(($ver -replace '[^0-9\.]', ''), [ref]$v)) {
        if ($v -gt [version]'8.5.1') {
            Write-Warning "Выгрузка сделана платформой $ver; 1C:EDT 2026.2 понимает формат только до 8.5.1. Для импорта в EDT используйте -PlatformVersion 8.3.27."
        }
    }
}
exit $code
