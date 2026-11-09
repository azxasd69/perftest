<#
.SYNOPSIS
    Регистрация COM-коннектора 1С V83.COMConnector (32-битное представление HKCR).

.DESCRIPTION
    Диагностика 08.11.2026 показала, что после переустановок/отката платформы реестр
    остался в смешанном виде:
      * CLSID {181E893D-73A4-4722-B61D-D604B3D67D47} -> comcntr.dll есть ТОЛЬКО в 32-битном
        представлении (HKCR -reg:32, ветка WOW6432Node);
      * TypeLib {98AC3B5B-5323-418F-8F07-E32F231D2393} лежит в HKCU\Software\Classes\TypeLib
        (запись 1.0\0\win32 + FLAGS=0), в HKLM нет вовсе.
    Результат: в x86-процессе класс создаётся (CoCreateInstance hr=0), а ITypeInfo при
    позднем связывании может отдавать TYPE_E_LIBNOTREGISTERED (0x8002801D).

    Скрипт приводит 32-битную регистрацию к штатному виду установщика 1С:
      1) HKCU\Software\Classes\TypeLib\{...}\1.0\0\win32: FLAGS = 128
         (LIBFLAG_FHASDISKIMAGE — тип-библиотека в DLL, а не в отдельном .tlb);
      2) справочный ключ HKCU\Software\Classes\1C\1Cv8\ComConnector32
         (InprocServer32, TypeLib, Bitness).
    64-битные ключи намеренно НЕ создаются: comcntr.dll x86, и регистрация CLSID для
    64-битной ветки привела бы к попытке загрузить 32-битную DLL в x64-процесс.

    Требует прав администратора (поднимает UAC). Перед изменением: .reg-бэкап в
    tools\com-registry-backup\ и журнал tools\com-registry-added.json, по которому
    работает -Revert.

.EXAMPLE
    pwsh -File tools\com-register.ps1
    pwsh -File tools\com-register.ps1 -Apply
    pwsh -File tools\com-register.ps1 -Revert
#>
[CmdletBinding()]
param(
    [switch]$Apply,
    [switch]$Revert,
    [string]$TypeLibGuid = '{98AC3B5B-5323-418F-8F07-E32F231D2393}',
    [string]$Clsid = '{181E893D-73A4-4722-B61D-D604B3D67D47}',
    [string]$ComCntr = 'C:\Program Files (x86)\1cv8\8.3.27.2342\bin\comcntr.dll',
    [string]$BackupDir = (Join-Path $PSScriptRoot 'com-registry-backup')
)

$ErrorActionPreference = 'Stop'
if (-not $env:TEMP) { $env:TEMP = Join-Path $env:USERPROFILE 'AppData\Local\Temp' }

$typeLibKey = "HKCU\Software\Classes\TypeLib\$TypeLibGuid\1.0\0\win32"
$refKey     = 'HKCU\Software\Classes\1C\1Cv8\ComConnector32'
$ledger     = Join-Path $PSScriptRoot 'com-registry-added.json'
$logFile    = Join-Path $env:TEMP 'com-register-out.txt'
$bodyPath   = Join-Path $env:TEMP 'com-register-body.ps1'

function Get-FlagsState([string]$key) {
    $q = & reg.exe query $key /v FLAGS 2>$null
    if ($LASTEXITCODE -ne 0) { return 'значения нет' }
    $m = [regex]::Match(($q -join "`n"), 'FLAGS\s+REG_\w+\s+(\S+)')
    if ($m.Success) { return $m.Groups[1].Value }
    return 'значения нет'
}

function Show-Plan {
    "32-битная регистрация (то, что видит x86-процесс):"
    & reg.exe query "HKCR\CLSID\$Clsid\InprocServer32" /reg:32 /ve 2>&1 | Where-Object { $_ -match 'REG_SZ' }
    "  CLSID /reg:32 -> " + $(if ($LASTEXITCODE -eq 0) { 'есть' } else { 'НЕТ' })
    "  TypeLib key: $typeLibKey"
    "  FLAGS сейчас: " + (Get-FlagsState $typeLibKey) + "  (нужно 128)"
    "  Справочный ключ: $refKey — " + $(if (Test-Path "HKCU:\Software\Classes\1C\1Cv8\ComConnector32") { 'есть' } else { 'нет' })
    "Бэкап: $BackupDir"
}

if (-not $Apply -and -not $Revert) {
    "ПЛАН (ничего не меняется):"
    Show-Plan
    ""
    "Изменения:  pwsh -File tools\com-register.ps1 -Apply"
    "Откат:      pwsh -File tools\com-register.ps1 -Revert"
    exit 0
}

$modeName = if ($Revert) { 'revert' } else { 'apply' }
"ПЛАН ($modeName):"
Show-Plan
""

$body = @'
param([string]$Mode, [string]$TypeLibKey, [string]$RefKey, [string]$BackupDir, [string]$Ledger, [string]$ComCntr, [string]$TypeLibGuid, [string]$LogFile)
$ErrorActionPreference = 'Continue'
Start-Transcript -Path $LogFile -Force | Out-Null
if ($Mode -eq 'apply') {
    New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $bak = Join-Path $BackupDir ("hkcu-typelib-$stamp.reg")
    & reg.exe export "HKCU\Software\Classes\TypeLib\$TypeLibGuid" $bak /y 2>&1 | Out-Null
    $before = (& reg.exe query $TypeLibKey /v FLAGS 2>$null | Select-String 'FLAGS').Line
    & reg.exe add $TypeLibKey /v FLAGS /t REG_DWORD /d 128 /f 2>&1 | Out-Null
    $rc1 = $LASTEXITCODE
    $after = (& reg.exe query $TypeLibKey /v FLAGS 2>$null | Select-String 'FLAGS').Line
    & reg.exe add $RefKey /v InprocServer32 /t REG_SZ /d $ComCntr /f 2>&1 | Out-Null
    & reg.exe add $RefKey /v TypeLib /t REG_SZ /d $TypeLibGuid /f 2>&1 | Out-Null
    & reg.exe add $RefKey /v Bitness /t REG_DWORD /d 32 /f 2>&1 | Out-Null
    $rc2 = $LASTEXITCODE
    $led = [ordered]@{ mode = 'apply'; timestamp = $stamp; backup = $bak; typeLibKey = $TypeLibKey; refKey = $RefKey; before = $before }
    [IO.File]::WriteAllText($Ledger, ($led | ConvertTo-Json), [Text.UTF8Encoding]::new($true))
    "  TypeLib FLAGS: " + $before + "  ->  " + $after + "   (rc=$rc1)"
    "  справочный ключ создан: rc=$rc2"
    "  бэкап: $bak (есть: $(Test-Path -LiteralPath $bak))"
    Stop-Transcript | Out-Null
    exit $rc1
}
if ($Mode -eq 'revert') {
    if (Test-Path -LiteralPath $Ledger) {
        $led = Get-Content -LiteralPath $Ledger -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($led.backup -and (Test-Path -LiteralPath $led.backup)) {
            & reg.exe delete "HKCU\Software\Classes\TypeLib\$TypeLibGuid" /f 2>&1 | Out-Null
            & reg.exe import $led.backup 2>&1 | Out-Null
            "  TypeLib восстановлен из $($led.backup)"
        }
        & reg.exe delete $RefKey /f 2>&1 | Out-Null
        "  справочный ключ удалён"
        Remove-Item -LiteralPath $Ledger -Force -ErrorAction SilentlyContinue
    } else {
        & reg.exe delete $TypeLibKey /v FLAGS /f 2>&1 | Out-Null
        "  журнала нет: удалено только значение FLAGS"
    }
    Stop-Transcript | Out-Null
    exit 0
}
'@
[IO.File]::WriteAllText($bodyPath, $body, [Text.UTF8Encoding]::new($true))

$argList = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$bodyPath`"", '-Mode', $modeName,
    '-TypeLibKey', "`"$typeLibKey`"", '-RefKey', "`"$refKey`"", '-BackupDir', "`"$BackupDir`"",
    '-Ledger', "`"$ledger`"", '-ComCntr', "`"$ComCntr`"", '-TypeLibGuid', "`"$TypeLibGuid`"", '-LogFile', "`"$logFile`"")

if (Test-Path -LiteralPath $logFile) { Remove-Item -LiteralPath $logFile -Force }
try {
    $p = Start-Process -FilePath 'powershell.exe' -ArgumentList $argList -Verb RunAs -Wait -PassThru -ErrorAction Stop
    "код выхода (elevated): $($p.ExitCode)"
} catch {
    "ОТКАЗ UAC или ошибка запуска: $($_.Exception.Message)"
    exit 2
}
if (Test-Path -LiteralPath $logFile) {
    Get-Content -LiteralPath $logFile -Encoding UTF8 | Where-Object { $_ -notmatch '^\*\*\*|^Transcript|^Windows PowerShell|^Майкрософт|^Отображение|^Команды' }
} else {
    "журнал elevated-процесса не найден: $logFile"
}

"Состояние после запуска:"
"  FLAGS = " + (Get-FlagsState $typeLibKey)
& reg.exe query $refKey 2>&1 | Where-Object { $_ -match 'InprocServer32|TypeLib|Bitness' }
