param(
    [Parameter(Mandatory = $true)][string]$Base,
    [string]$BackupDir = ''
)

# Очистка журнала регистрации ФАЙЛОВОЙ информационной базы.
#
# Платформа не поддерживает ОчиститьЖурналРегистрации для файлового варианта
# («Метод не поддерживается данной реализацией журнала регистрации»), поэтому
# журнал чистится на уровне файлов: удаляются *.lgp (данные) и *.lgx (индекс),
# 1Cv8.lgf остаётся - платформа создаёт новый файл данных сама.
#
# База должна быть закрыта: скрипт проверяет, что файлы журнала не удерживаются
# процессом, и отказывается работать, если база открыта.
#
# Пример: pwsh -File tools\log-clear.ps1 -Base d:\InfoBasePerf -BackupDir scratch

$ErrorActionPreference = 'Stop'
$full = [IO.Path]::GetFullPath($Base, (Get-Location).Path)
$log = Join-Path $full '1Cv8Log'

if (-not (Test-Path $log)) {
    "журнала нет: $log"
    exit 0
}

$files = @(Get-ChildItem -Path $log -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Extension -eq '.lgp' -or $_.Extension -eq '.lgx' })

if ($files.Count -eq 0) {
    "журнал уже пуст: $log"
    exit 0
}

# База открыта, если файл журнала нельзя открыть на монопольный доступ.
foreach ($f in $files) {
    try {
        $stream = [IO.File]::Open($f.FullName, 'Open', 'ReadWrite', 'None')
        $stream.Close()
    }
    catch {
        "база занята (файл $($f.Name) удерживается процессом 1С): очистка отменена"
        exit 2
    }
}

if (-not [string]::IsNullOrWhiteSpace($BackupDir)) {
    $target = [IO.Path]::GetFullPath($BackupDir, (Get-Location).Path)
    New-Item -ItemType Directory -Force -Path $target | Out-Null
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $copy = Join-Path $target "1Cv8Log-$stamp"
    Copy-Item $log $copy -Recurse
    "копия журнала: $copy"
}

$removed = 0
foreach ($f in $files) {
    Remove-Item $f.FullName -Force
    $removed++
}
"удалено файлов журнала: $removed (1Cv8.lgf оставлен)"
exit 0
