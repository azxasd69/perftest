param(
    [string]$Base = 'd:\InfoBasePerf',
    [string]$Out = 'scratch\ui-run',
    [int]$WarmupSec = 24,
    [string]$Steps = '',
    [switch]$KeepAlive,
    [string]$Exe = 'C:\Program Files (x86)\1cv8\8.3.27.2342\bin\1cv8.exe',
    [bool]$MinimizeOthers = $true
)

# Живой UI-сценарий «ПерфТест»: запускает клиент, поднимает окно поверх всех и
# проходит шаги мышью/клавиатурой, снимая экран после каждого шага.
#
# Почему так, а не через DOM: переход по меню закрывает текущую форму и открывает
# следующую, поэтому живой сценарий исполняется снаружи - настоящими кликами.
#
# Защита от чужих окон: перед каждым кликом проверяется, что на переднем плане
# процесс 1cv8*; иначе клик ОТМЕНЯЕТСЯ (в прошлый раз клики уходили в окно
# AutoClaw и сценарий «молчал»).
#
# Зависания: у каждого шага свой предел; по исчерпании сценарий останавливается,
# делает снимок и снимает ВСЁ дерево процессов 1С (стартовый стаб 1cv8.exe
# порождает реальный клиент, поэтому убивать надо по имени, а не по pid).
#
# Шаги: click:X,Y   wait:СЕК   shot:ИМЯ   key:Tab
# Пример: -Steps "click:90,243;wait:2;shot:menu1;click:90,514;wait:3;shot:journal"

$ErrorActionPreference = 'Stop'
$env:LOCALAPPDATA = "$env:USERPROFILE\AppData\Local"
$profileRoot = [IO.Path]::GetFullPath('scratch\ui-profile', (Get-Location).Path)
New-Item -ItemType Directory -Force -Path (Join-Path $profileRoot 'Roaming\1C\1cv8') | Out-Null
$env:APPDATA = Join-Path $profileRoot 'Roaming'
$full = [IO.Path]::GetFullPath($Base, (Get-Location).Path)
$outDir = [IO.Path]::GetFullPath($Out, (Get-Location).Path)
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$log = Join-Path $outDir 'ui-scenario.log'
function Say([string]$text) {
    $line = (Get-Date -Format 'HH:mm:ss') + ' ' + $text
    Write-Host $line
    Add-Content -Path $log -Value $line -Encoding UTF8
}
if (Test-Path $log) { Remove-Item $log -Force }

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class W9 {
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c);
  [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr h, IntPtr after, int x, int y, int cx, int cy, uint flags);
  [DllImport("user32.dll")] public static extern bool SetCursorPos(int x, int y);
  [DllImport("user32.dll")] public static extern void mouse_event(uint f, uint dx, uint dy, int d, UIntPtr e);
  [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
  [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
  [DllImport("user32.dll")] public static extern bool AttachThreadInput(uint attach, uint attachTo, bool doAttach);
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
  [DllImport("kernel32.dll")] public static extern uint GetCurrentThreadId();
  [DllImport("user32.dll")] public static extern void keybd_event(byte vk, byte scan, uint flags, UIntPtr extra);
  public struct RECT { public int Left, Top, Right, Bottom; }
}
"@
$TOPMOST = [IntPtr](-1)
$SWP = 0x0001 -bor 0x0002 -bor 0x0040

function FindWindow() {
    $best = [IntPtr]::Zero
    foreach ($pr in Get-Process | Where-Object { $_.ProcessName -like '1cv8*' }) {
        $pr.Refresh()
        if ($pr.MainWindowHandle -ne [IntPtr]::Zero) { $best = $pr.MainWindowHandle }
    }
    $best
}

function ForegroundIs1C() {
    $h = [W9]::GetForegroundWindow()
    $procId = [uint32]0
    [void][W9]::GetWindowThreadProcessId($h, [ref]$procId)
    if ($procId -eq 0) { return $false }
    $pr = Get-Process -Id $procId -ErrorAction SilentlyContinue
    return ($pr -and $pr.ProcessName -like '1cv8*')
}

# Подъём окна: ALT «разблокирует» SetForegroundWindow, AttachThreadInput делает
# вызов легитимным для чужого потока (иначе Windows не отдаёт фокус).
function Raise() {
    $h = FindWindow
    if ($h -eq [IntPtr]::Zero) { return $false }
    [void][W9]::ShowWindow($h, 5)
    [void][W9]::SetWindowPos($h, $TOPMOST, 0, 0, 0, 0, $SWP)
    $fg = [W9]::GetForegroundWindow()
    $fgThread = [uint32]0
    [void][W9]::GetWindowThreadProcessId($fg, [ref]$fgThread)
    $myThread = [uint32][W9]::GetCurrentThreadId()
    [void][W9]::AttachThreadInput($myThread, [uint32]$fgThread, $true)
    [void][W9]::keybd_event(0x12, 0, 0, [UIntPtr]::Zero)
    [void][W9]::SetForegroundWindow($h)
    [void][W9]::keybd_event(0x12, 0, 2, [UIntPtr]::Zero)
    [void][W9]::AttachThreadInput($myThread, [uint32]$fgThread, $false)
    Start-Sleep -Milliseconds 700
    return $true
}

# Посторонние окна на время прогона: они перекрывают 1С и перехватывают клики
# (проверено: окно SiteRestorer забирало нажатия). Список восстанавливается в конце.
$script:minimized = @()
function MinimizeOthers() {
    $one = FindWindow
    foreach ($pr in Get-Process) {
        if ($pr.ProcessName -like '1cv8*') { continue }
        if ($pr.MainWindowHandle -eq [IntPtr]::Zero) { continue }
        if ($pr.MainWindowHandle -eq $one) { continue }
        [void][W9]::ShowWindow($pr.MainWindowHandle, 6)
        $script:minimized += $pr.MainWindowHandle
    }
    Say ('свернуто посторонних окон: ' + $script:minimized.Count)
    Start-Sleep -Milliseconds 800
}

function RestoreOthers() {
    foreach ($h in $script:minimized) { [void][W9]::ShowWindow($h, 9) }
    if ($script:minimized.Count -gt 0) { Say ('восстановлено окон: ' + $script:minimized.Count) }
    $script:minimized = @()
}

# Активация окна кликом по строке заголовка: без этого первый клик по странице
# только активирует окно, а до HTML-поля не доходит (проверено 09.11.2026).
function ActivateWindow() {
    $h = FindWindow
    if ($h -eq [IntPtr]::Zero) { return $false }
    if ([W9]::GetForegroundWindow() -eq $h) { return $true }
    $wr = New-Object W9+RECT
    [void][W9]::GetWindowRect($h, [ref]$wr)
    [void][W9]::SetCursorPos($wr.Left + 300, $wr.Top + 12)
    Start-Sleep -Milliseconds 150
    [W9]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)
    Start-Sleep -Milliseconds 60
    [W9]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
    Start-Sleep -Milliseconds 500
    return ([W9]::GetForegroundWindow() -eq $h)
}

# Снимок окна целиком: CopyFromScreen по прямоугольнику окна (PrintWindow не
# снимает содержимое HTML-поля - оно в отдельной поверхности WebKit).
function Shot([string]$name) {
    $h = FindWindow
    $rect = New-Object W9+RECT
    if ($h -ne [IntPtr]::Zero -and [W9]::GetWindowRect($h, [ref]$rect)) {
        $w = $rect.Right - $rect.Left
        $hh = $rect.Bottom - $rect.Top
        $bmp = New-Object Drawing.Bitmap $w, $hh
        $g = [Drawing.Graphics]::FromImage($bmp)
        $g.CopyFromScreen($rect.Left, $rect.Top, 0, 0, $bmp.Size)
    }
    else {
        $vs = [System.Windows.Forms.SystemInformation]::VirtualScreen
        $bmp = New-Object Drawing.Bitmap $vs.Width, $vs.Height
        $g = [Drawing.Graphics]::FromImage($bmp)
        $g.CopyFromScreen($vs.X, $vs.Y, 0, 0, $bmp.Size)
    }
    $path = Join-Path $outDir ("shot-" + $name + '.png')
    $bmp.Save($path, [Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Say ("снимок " + $path)
}

$p = Start-Process -FilePath $Exe -ArgumentList 'ENTERPRISE', "/F$full" -PassThru
Say ("запуск: pid=" + $p.Id + " база=" + $full)
Start-Sleep -Seconds $WarmupSec
if (-not (Raise)) { Say 'окно 1С не найдено - сценарий остановлен'; exit 1 }
$wh0 = FindWindow
# Окно приводится к одному прямоугольнику: maximized-окно в разных сеансах
# получало то (-8,-8,1928,1040), то (0,0,1920,1080), и клики уходили мимо.
[void][W9]::ShowWindow($wh0, 9)
Start-Sleep -Milliseconds 500
[void][W9]::SetWindowPos($wh0, $TOPMOST, 0, 0, 1920, 1040, $SWP)
Start-Sleep -Milliseconds 800
$wr0 = New-Object W9+RECT
[void][W9]::GetWindowRect($wh0, [ref]$wr0)
Say ('окно: left=' + $wr0.Left + ' top=' + $wr0.Top + ' right=' + $wr0.Right + ' bottom=' + $wr0.Bottom)
if ($MinimizeOthers) { MinimizeOthers }
[void](Raise)
Shot '00-start'

$cancelled = 0
foreach ($raw in ($Steps -split ';')) {
    $step = $raw.Trim()
    if ([string]::IsNullOrWhiteSpace($step)) { continue }
    $parts = $step.Split(':')
    $action = $parts[0].ToLower()
    $arg = if ($parts.Count -gt 1) { $parts[1] } else { '' }

    switch ($action) {
        'wait' {
            Start-Sleep -Seconds ([double]$arg)
            Say ("шаг wait " + $arg)
        }
        'shot' {
            [void](Raise)
            Shot $arg
        }
        'key' {
            if (-not (ForegroundIs1C)) { Say 'клавиша отменена: 1С не на переднем плане'; continue }
            [System.Windows.Forms.SendKeys]::SendWait($arg)
            Say ("шаг key " + $arg)
        }
        'click' {
            $whNow = FindWindow
            if ([W9]::GetForegroundWindow() -ne $whNow) {
                [void](Raise)
                if (-not (ActivateWindow)) {
                    $cancelled++
                    Say ('клик ' + $arg + ' ОТМЕНЕН: окно 1С не активно (подряд ' + $cancelled + ')')
                    if ($cancelled -ge 3) { Say 'три отмены подряд - сценарий остановлен'; break }
                    continue
                }
                Say 'окно 1С активировано кликом по заголовку'
            }
            $cancelled = 0
            # Координаты шага заданы от левого верхнего угла ОКНА: снимки делаются
            # по прямоугольнику окна, поэтому калибровка и клик живут в одной системе.
            $wh = FindWindow
            $wr = New-Object W9+RECT
            [void][W9]::GetWindowRect($wh, [ref]$wr)
            $xy = $arg.Split(',')
            $sx = $wr.Left + [int]$xy[0]
            $sy = $wr.Top + [int]$xy[1]
            [void][W9]::SetCursorPos($sx, $sy)
            Start-Sleep -Milliseconds 200
            [W9]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)
            Start-Sleep -Milliseconds 60
            [W9]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
            Say ('шаг click ' + $arg + ' (экран ' + $sx + ',' + $sy + ')')
        }
        default { Say ('неизвестный шаг: ' + $step) }
    }
}

Shot '99-final'
if (-not $KeepAlive) {
    $left = @(Get-Process | Where-Object { $_.ProcessName -like '1cv8*' })
    foreach ($pr in $left) { try { $pr.Kill() } catch { } }
    Say ('закрыто процессов 1С: ' + $left.Count)
}
if ($MinimizeOthers) { RestoreOthers }
Say 'сценарий завершен'
