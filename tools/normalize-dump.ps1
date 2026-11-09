# Нормализация выгрузки 1С: убирает шум, который добавляется при каждом сохранении
# из конфигуратора, чтобы git diff показывал только смысловые правки.
#
# Эталон проекта (так пишет платформа и так хранится в git):
#   - UTF-8 с BOM;
#   - окончания строк CRLF;
#   - незначащий порядок узлов отсортирован: <Item> в Style.xml по name,
#     строки <File> в ConfigDumpInfo.xml по имени.
# Порядок реквизитов, свойств и дочерних объектов НЕ трогается: он влияет
# на дерево метаданных и на последовательность элементов в XSD.
#
# Использование:
#   pwsh -NoProfile -File tools\normalize-dump.ps1                  # проверка (код 2, если есть что править)
#   pwsh -NoProfile -File tools\normalize-dump.ps1 -Apply           # применить
#   pwsh -NoProfile -File tools\normalize-dump.ps1 -Path . -Apply
#   pwsh -NoProfile -File tools\normalize-dump.ps1 -Apply -StripBom -Lf   # если политика репозитория изменится
param(
    [string]$Path = '.',
    [switch]$Apply,
    [switch]$StripBom,
    [switch]$Lf,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$root = (Resolve-Path -LiteralPath $Path).Path
$pattern = @('*.bsl', '*.xml')

function Sort-StyleItems {
    param([string]$Text)
    $match = [regex]::Matches($Text, '(?s)<Item name="([^"]+)">.*?</Item>')
    if ($match.Count -lt 2) { return $Text }
    $blocks = @()
    foreach ($m in $match) { $blocks += [pscustomobject]@{ Name = $m.Groups[1].Value; Text = $m.Value } }
    $nl = if ($Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    $sorted = ($blocks | Sort-Object Name | ForEach-Object { $_.Text }) -join $nl
    $first = $match[0]
    $last = $match[$match.Count - 1]
    return $Text.Substring(0, $first.Index) + $sorted + $Text.Substring($last.Index + $last.Length)
}

function Sort-DumpInfoFiles {
    param([string]$Text)
    $match = [regex]::Matches($Text, '(?m)^[ \t]*<File [^>]*/>')
    if ($match.Count -lt 2) { return $Text }
    $lines = @($match | ForEach-Object { $_.Value.Trim() } | Sort-Object)
    $first = $match[0]
    $last = $match[$match.Count - 1]
    $indent = ' ' * ($first.Value.Length - $first.Value.TrimStart().Length)
    $nl = if ($Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    return $Text.Substring(0, $first.Index) + (($lines | ForEach-Object { $indent + $_ }) -join $nl) + $Text.Substring($last.Index + $last.Length)
}

$utf8Bom = [Text.UTF8Encoding]::new($true)
$utf8NoBom = [Text.UTF8Encoding]::new($false)

$files = Get-ChildItem -LiteralPath $root -Recurse -File -Include $pattern
$nBom = 0
$nEol = 0
$nSort = 0
$touched = New-Object System.Collections.Generic.List[string]

foreach ($file in $files) {
    $bytes = [IO.File]::ReadAllBytes($file.FullName)
    $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    $text = if ($hasBom) { $utf8Bom.GetString($bytes, 3, $bytes.Length - 3) } else { $utf8Bom.GetString($bytes) }

    $wantBom = -not $StripBom
    $new = $text
    $didBom = ($hasBom -ne $wantBom)
    $didEol = $false
    $didSort = $false

    if ($Lf) {
        if ($new.Contains("`r`n")) { $new = $new.Replace("`r`n", "`n"); $didEol = $true }
    }
    else {
        $normalized = ($new -replace "`r`n", "`n").Replace("`n", "`r`n")
        if ($normalized -ne $new) { $new = $normalized; $didEol = $true }
    }

    if ($file.Name -eq 'Style.xml') {
        $sorted = Sort-StyleItems -Text $new
        if ($sorted -ne $new) { $new = $sorted; $didSort = $true }
    }
    elseif ($file.Name -eq 'ConfigDumpInfo.xml') {
        $sorted = Sort-DumpInfoFiles -Text $new
        if ($sorted -ne $new) { $new = $sorted; $didSort = $true }
    }

    if ($didBom -or $didEol -or $didSort) {
        $touched.Add($file.FullName.Substring($root.Length + 1))
        if ($didBom) { $nBom++ }
        if ($didEol) { $nEol++ }
        if ($didSort) { $nSort++ }
        if ($Apply) {
            [IO.File]::WriteAllText($file.FullName, $new, $(if ($wantBom) { $utf8Bom } else { $utf8NoBom }))
        }
    }
}

if (-not $Quiet) {
    "Каталог: $root"
    "Файлов просмотрено: $($files.Count)"
    "Требуют правки: $($touched.Count) (BOM: $nBom, EOL: $nEol, порядок: $nSort)"
    if ($touched.Count -gt 0 -and -not $Apply) {
        "Ничего не изменено (добавьте -Apply)."
        $touched | Select-Object -First 8 | ForEach-Object { "  $_" }
    }
    if ($Apply) { "Применено." }
}

if ($touched.Count -gt 0 -and -not $Apply) { exit 2 }
exit 0
