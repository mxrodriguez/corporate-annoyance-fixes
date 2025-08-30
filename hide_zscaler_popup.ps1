# Hide Zscaler Authentication Popup Script
# This script hides/minimizes Zscaler authentication windows without killing processes

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32 {
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        
        [DllImport("user32.dll")]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
        
        [DllImport("user32.dll")]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
        
        public const int SW_HIDE = 0;
        public const int SW_MINIMIZE = 6;
        public const uint SWP_HIDEWINDOW = 0x0080;
    }
"@

Write-Host "Monitoring for Zscaler authentication windows - Press Ctrl+C to stop"

while ($true) {
    # Look for common Zscaler authentication window titles
    $windowTitles = @(
        "Zscaler",
        "Authentication Required", 
        "Zscaler Client Connector",
        "Login Required",
        "ZCC Authentication",
        "Zscaler Sign In"
    )
    
    foreach ($title in $windowTitles) {
        $hwnd = [Win32]::FindWindow($null, $title)
        if ($hwnd -ne [IntPtr]::Zero) {
            Write-Host "$(Get-Date): Hiding window: $title"
            [Win32]::ShowWindow($hwnd, [Win32]::SW_HIDE) | Out-Null
        }
    }
    
    Start-Sleep -Seconds 2
}
