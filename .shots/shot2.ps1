param([string]$OutFile = "C:\Users\33685\lecture6\.shots\test2.png")
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public class Wake {
  [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
  [StructLayout(LayoutKind.Sequential)] public struct MOUSEINPUT { public int dx; public int dy; public uint mouseData; public uint dwFlags; public uint time; public IntPtr dwExtraInfo; }
  [StructLayout(LayoutKind.Sequential)] public struct INPUT { public uint type; public MOUSEINPUT mi; }
  public const uint INPUT_MOUSE = 0; public const uint MOUSEEVENTF_MOVE = 0x0001;
  public static void Nudge() {
    INPUT[] inp = new INPUT[1];
    inp[0].type = INPUT_MOUSE; inp[0].mi = new MOUSEINPUT(); inp[0].mi.dx = 1; inp[0].mi.dy = 1; inp[0].mi.dwFlags = MOUSEEVENTF_MOVE;
    SendInput(1, inp, Marshal.SizeOf(typeof(INPUT)));
    System.Threading.Thread.Sleep(200);
    inp[0].mi.dx = -1; inp[0].mi.dy = -1;
    SendInput(1, inp, Marshal.SizeOf(typeof(INPUT)));
  }
  [DllImport("user32.dll", SetLastError = true)] public static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);
}
'@
[Wake]::SetProcessDPIAware() | Out-Null
[Wake]::Nudge()
Start-Sleep -Seconds 3
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$b = [System.Windows.Forms.SystemInformation]::VirtualScreen
$bmp = New-Object System.Drawing.Bitmap($b.Width, $b.Height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($b.X, $b.Y, 0, 0, $bmp.Size)
$bmp.Save($OutFile, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
# quick brightness check: sample average of a few pixels
$sum = 0
for ($x = 100; $x -lt 2400; $x += 500) { $c = $bmp.GetPixel($x, 800); $sum += ($c.R + $c.G + $c.B) }
Write-Output "BRIGHTNESS_SAMPLE=$sum"
