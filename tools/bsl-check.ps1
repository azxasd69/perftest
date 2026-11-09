<#
.SYNOPSIS
    Проверка BSL-модулей 1С через BSL Language Server (CLI).

.DESCRIPTION
    Замена платному MCP-серверу 1c-syntax-checker-mcp: тот же движок
    (BSL Language Server), но локально, без MCP-транспорта и без лицензии.
    Запускает `bsl-language-server analyze`, читает JSON-отчёт и печатает
    диагностику в виде `файл:строка:колонка Severity Code — сообщение`.

    Код возврата: 0 — ошибок нет, 1 — есть диагностика уровня Error,
                  2 — не удалось запустить проверку (нет jar/java/отчёта).

.PARAMETER Path
    Один или несколько путей: файл .bsl/.os или каталог с исходниками.

.PARAMETER Severity
    Минимальная важность для вывода: Error (по умолчанию), Warning, Info, All.
    На код возврата влияет только Error.

.PARAMETER Config
    Путь к конфигурации BSL Language Server (.bsl-language-server.json).

.PARAMETER Json
    Вывести результат одной JSON-строкой (для машинной обработки).

.PARAMETER KeepReport
    Не удалять каталог с отчётом; путь печатается в конце.

.EXAMPLE
    .\tools\bsl-check.ps1 -Path 1c\project\src

.EXAMPLE
    .\tools\bsl-check.ps1 -Path .\Module.bsl -Severity All
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string[]]$Path,

    [ValidateSet('Error', 'Warning', 'Info', 'All')]
    [string]$Severity = 'Error',

    [string]$Config,

    [switch]$Json,

    [switch]$KeepReport,

    [int]$TimeoutSec = 600
)

$ErrorActionPreference = 'Stop'

# --- окружение: агентский шелл теряет ProgramFiles(x86) и PROCESSOR_ARCHITECTURE ---
# BSL Language Server ищет платформы по файловой системе (ProgramFiles,
# ProgramFiles(x86), ProgramW6432), а не в реестре. Если ProgramFiles(x86) пуста,
# в лог уходит "No 1C platform installations found on this machine" и контекст
# платформы не загружается — проверка идёт без справки API.
# Восстанавливаем из реестра Windows: значения системные, прав администратора не нужно.
function Restore-PlatformEnv {
    $cv = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
    $map = @(
        @{ RegName = 'ProgramFilesDir'; EnvName = 'ProgramFiles' },
        @{ RegName = 'ProgramFilesDir (x86)'; EnvName = 'ProgramFiles(x86)' },
        @{ RegName = 'ProgramW6432Dir'; EnvName = 'ProgramW6432' }
    )
    foreach ($item in $map) {
        if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($item.EnvName))) {
            $value = (Get-ItemProperty -Path $cv -Name $item.RegName -ErrorAction SilentlyContinue).($item.RegName)
            if ($value) { [Environment]::SetEnvironmentVariable($item.EnvName, $value, 'Process') }
        }
    }
    if ([string]::IsNullOrWhiteSpace($env:PROCESSOR_ARCHITECTURE)) {
        $arch = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name 'PROCESSOR_ARCHITECTURE' -ErrorAction SilentlyContinue).PROCESSOR_ARCHITECTURE
        if ($arch) { [Environment]::SetEnvironmentVariable('PROCESSOR_ARCHITECTURE', $arch, 'Process') }
    }
}

Restore-PlatformEnv

function Resolve-Jar {
    $candidates = @()
    if ($env:BSL_LS_JAR) { $candidates += $env:BSL_LS_JAR }
    $candidates += (Join-Path $env:USERPROFILE 'tools\bsl\bsl-language-server.jar')
    foreach ($c in $candidates) {
        if ($c -and (Test-Path -LiteralPath $c)) { return (Resolve-Path -LiteralPath $c).Path }
    }
    return $null
}

function Resolve-Java {
    if ($env:JAVA_HOME) {
        $p = Join-Path $env:JAVA_HOME 'bin\java.exe'
        if (Test-Path -LiteralPath $p) { return $p }
    }
    $cmd = Get-Command java -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    return $null
}

function ConvertFrom-FileUri {
    param([string]$Value)
    if (-not $Value) { return $null }
    if ($Value -like 'file://*') {
        try { return ([Uri]$Value).LocalPath } catch { return $Value }
    }
    return $Value
}

# --- проверка окружения ---------------------------------------------------
$jar = Resolve-Jar
if (-not $jar) {
    Write-Error 'BSL Language Server не найден. Ожидается %USERPROFILE%\tools\bsl\bsl-language-server.jar или переменная BSL_LS_JAR.'
    exit 2
}
$java = Resolve-Java
if (-not $java) {
    Write-Error 'java не найдена: задайте JAVA_HOME или добавьте Java в PATH.'
    exit 2
}

# --- нормализация входных путей ------------------------------------------
$files = New-Object System.Collections.Generic.List[string]
$dirs = New-Object System.Collections.Generic.List[string]
foreach ($raw in $Path) {
    if (-not (Test-Path -LiteralPath $raw)) {
        Write-Error "Путь не найден: $raw"
        exit 2
    }
    $item = Get-Item -LiteralPath $raw
    if ($item.PSIsContainer) {
        $dirs.Add($item.FullName)
    }
    else {
        $files.Add($item.FullName)
        $parent = $item.Directory.FullName
        if (-not $dirs.Contains($parent)) { $dirs.Add($parent) }
    }
}

$severityRank = @{ 'Error' = 3; 'Warning' = 2; 'Information' = 1; 'Hint' = 1; 'Info' = 1 }
$minRank = switch ($Severity) {
    'Error' { 3 }
    'Warning' { 2 }
    default { 0 }
}

$results = New-Object System.Collections.Generic.List[object]
$failures = New-Object System.Collections.Generic.List[string]
$analyzed = New-Object System.Collections.Generic.List[string]

foreach ($dir in $dirs) {
    $outDir = Join-Path ([IO.Path]::GetTempPath()) ('bsl-check-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    try {
        $javaArgs = @('-jar', $jar, 'analyze', '-s', $dir, '-o', $outDir, '-r', 'json', '-q')
        if ($Config) { $javaArgs += @('-c', (Resolve-Path -LiteralPath $Config).Path) }

        $proc = Start-Process -FilePath $java -ArgumentList $javaArgs -NoNewWindow -PassThru -RedirectStandardOutput (Join-Path $outDir 'stdout.txt') -RedirectStandardError (Join-Path $outDir 'stderr.txt')
        if (-not $proc.WaitForExit($TimeoutSec * 1000)) {
            try { $proc.Kill() } catch { }
            $failures.Add("Таймаут ${TimeoutSec}s на каталоге $dir")
            continue
        }

        $report = Join-Path $outDir 'bsl-json.json'
        if (-not (Test-Path -LiteralPath $report)) {
            $err = ''
            $errFile = Join-Path $outDir 'stderr.txt'
            if (Test-Path -LiteralPath $errFile) { $err = (Get-Content -LiteralPath $errFile -Encoding UTF8 -Raw) }
            $failures.Add("Нет отчёта для $dir. " + ($err -split "`n" | Select-Object -Last 3 | Out-String).Trim())
            continue
        }

        $data = Get-Content -LiteralPath $report -Encoding UTF8 -Raw | ConvertFrom-Json
        foreach ($fi in @($data.fileinfos)) {
            $filePath = ConvertFrom-FileUri $fi.path
            if (-not $filePath) { continue }
            $full = [IO.Path]::GetFullPath($filePath)
            if ($files.Count -gt 0 -and -not ($files | Where-Object { $_ -eq $full })) { continue }
            if (-not $analyzed.Contains($full)) { $analyzed.Add($full) }

            foreach ($d in @($fi.diagnostics)) {
                if (-not $d) { continue }
                $sev = [string]$d.severity
                $rank = 0
                if ($severityRank.ContainsKey($sev)) { $rank = $severityRank[$sev] }
                if ($rank -lt $minRank) { continue }
                $results.Add([pscustomobject]@{
                        File     = $full
                        Line     = [int]$d.range.start.line + 1
                        Column   = [int]$d.range.start.character + 1
                        Severity = $sev
                        Code     = [string]$d.code
                        Message  = [string]$d.message
                    })
            }
        }
    }
    finally {
        if ($KeepReport) {
            Write-Verbose "Отчёт сохранён: $outDir"
        }
        elseif (Test-Path -LiteralPath $outDir) {
            Remove-Item -LiteralPath $outDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# --- вывод ----------------------------------------------------------------
$ordered = $results | Sort-Object File, Line, Column, Severity, Code, Message -Unique
$errors = @($ordered | Where-Object { $_.Severity -eq 'Error' })
$warnings = @($ordered | Where-Object { $_.Severity -eq 'Warning' })

if ($Json) {
    [pscustomobject]@{
        ok       = ($errors.Count -eq 0 -and $failures.Count -eq 0)
        checked  = $analyzed.Count
        errors   = $errors.Count
        warnings = $warnings.Count
        failures = @($failures)
        diagnostics = @($ordered | ForEach-Object {
                [pscustomobject]@{
                    file = $_.File; line = $_.Line; column = $_.Column
                    severity = $_.Severity; code = $_.Code; message = $_.Message
                }
            })
    } | ConvertTo-Json -Depth 5 -Compress
}
else {
    foreach ($d in $ordered) {
        '{0}({1},{2}): {3} {4}: {5}' -f $d.File, $d.Line, $d.Column, $d.Severity, $d.Code, $d.Message
    }
    foreach ($f in $failures) { "FAIL: $f" }
    "---"
    "Проверено файлов: {0}; диагностика: ошибок {1}, предупреждений {2}; сбоев {3}" -f `
    $analyzed.Count, $errors.Count, $warnings.Count, $failures.Count
}

if ($failures.Count -gt 0) { exit 2 }
if ($errors.Count -gt 0) { exit 1 }
exit 0
