<#
.SYNOPSIS
    Read-only запрос к ИБ 1С через 32-битный COM-коннектор V83.COMConnector.

.DESCRIPTION
    comcntr.dll платформы 1С — 32-битная, поэтому коннектор доступен только процессам x86.
    Обёртка находит 32-битный Python (по умолчанию <python32-dir>\python.exe) и запускает
    tools\com-query.py, возвращая JSON. Ничего в ИБ не пишется: разрешены только ВЫБРАТЬ.

    Для базы с аутентификацией задайте строку соединения через переменную окружения
    ONEC_CONNINFO (например: Usr="admin";Pwd="...").

.EXAMPLE
    pwsh -File tools\com-query.ps1 -Base d:\InfoBasePerf -Query "ВЫБРАТЬ Стенд, Сценарий, МедианаМс ИЗ РегистрСведений.ПерфРезультаты"

.EXAMPLE
    pwsh -File tools\com-query.ps1 -Base d:\InfoBasePerf -Info
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Base,
    [string]$Query,
    [switch]$Info,
    [string]$User = '',
    [int]$MaxRows = 100,
    [switch]$Table,
    [string]$Python = '<python32-dir>\python.exe'
)

$ErrorActionPreference = 'Stop'
$env:LOCALAPPDATA = "$env:USERPROFILE\AppData\Local"
$env:APPDATA      = "$env:USERPROFILE\AppData\Roaming"
$env:TEMP         = "$env:LOCALAPPDATA\Temp"
$env:PYTHONIOENCODING = 'utf-8'

if (-not (Test-Path -LiteralPath $Python)) {
    Write-Error "32-битный Python не найден: $Python (см. tools\README-com.md)"
    exit 3
}
$script = Join-Path $PSScriptRoot 'com-query.py'

$argv = @($script, '--base', $Base, '--max-rows', "$MaxRows")
if ($User) { $argv += @('--user', $User) }
if ($Info) { $argv += '--info' }
if ($Table) { $argv += '--table' }
if ($Query) { $argv += @('--query', $Query) }

& $Python @argv
exit $LASTEXITCODE
