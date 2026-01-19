# WindowsDialogHandler.ps1
# PowerShell equivalent of WindowsDialogHandler.cpp
# Finds a dialog window and sets text in an edit box, then clicks a button

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WindowInterop {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr GetDlgItem(IntPtr hDlg, int nIDDlgItem);

    [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern bool SetWindowText(IntPtr hWnd, string lpString);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetFocus(IntPtr hWnd);

    [DllImport("kernel32.dll")]
    public static extern void Sleep(uint dwMilliseconds);

    // Message constants
    public const uint WM_SETTEXT = 0x000C;
    public const uint BM_CLICK = 0x00F5;
    public const int IDOK = 1;
}
"@

Add-Type -AssemblyName System.Windows.Forms

# Constants
$WINDOW_CLASS = "#32770"
$WINDOW_TITLE = "Choose File to Upload"
$EDIT_BOX_ID = 0x47C  # File name Edit Box ID
$FILE_PATH = "C:\WorkingFolder\Programming\IE2\ForUpload.txt"

# Find the dialog window
$hwnd = [WindowInterop]::FindWindow($WINDOW_CLASS, $WINDOW_TITLE)

if ($hwnd -ne [IntPtr]::Zero) {
    Write-Host "Dialog Found!"

    # Bring the dialog to the foreground
    [WindowInterop]::SetForegroundWindow($hwnd) | Out-Null
    [WindowInterop]::Sleep(200)

    # Get the edit box control
    $hEditBox = [WindowInterop]::GetDlgItem($hwnd, $EDIT_BOX_ID)

    if ($hEditBox -ne [IntPtr]::Zero) {
        # Set focus to the edit box
        [WindowInterop]::SetFocus($hEditBox) | Out-Null
        [WindowInterop]::Sleep(200)

        # Clear any existing text and type the file path using SendKeys
        [System.Windows.Forms.SendKeys]::SendWait("^a")  # Select all
        [WindowInterop]::Sleep(100)
        [System.Windows.Forms.SendKeys]::SendWait($FILE_PATH)
        Write-Host "File Path Typed to Edit Box"

        [WindowInterop]::Sleep(500)

        # Get and click the Open Button
        $hButton = [WindowInterop]::GetDlgItem($hwnd, [WindowInterop]::IDOK)

        if ($hButton -ne [IntPtr]::Zero) {
            # Send Click Message to the Button
            [WindowInterop]::SendMessage($hButton, [WindowInterop]::BM_CLICK, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
            Write-Host "Open Button Clicked"
        }
        else {
            Write-Host "Open Button Not Found!"
        }
    }
    else {
        Write-Host "Edit Box Not Found!"
    }
}
else {
    Write-Host "Dialog Not Found!"
}
