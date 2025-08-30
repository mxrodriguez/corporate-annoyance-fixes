# Enhanced Zscaler Authentication Popup Script
# This script hides/minimizes Zscaler authentication windows without killing processes
# Version 2.0 - Improved detection and debugging

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    using System.Text;
    
    public class Win32 {
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        
        [DllImport("user32.dll")]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
        
        [DllImport("user32.dll")]
        public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
        
        [DllImport("user32.dll")]
        public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
        
        [DllImport("user32.dll")]
        public static extern int GetWindowTextLength(IntPtr hWnd);
        
        [DllImport("user32.dll")]
        public static extern bool IsWindowVisible(IntPtr hWnd);
        
        [DllImport("user32.dll")]
        public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
        
        public const int SW_HIDE = 0;
        public const int SW_MINIMIZE = 6;
        
        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
    }
"@

Write-Host "Enhanced Zscaler Popup Ninja v2.0 - Press Ctrl+C to stop" -ForegroundColor Green
Write-Host "Monitoring every 1 second for faster detection..." -ForegroundColor Yellow

$hiddenCount = 0

while ($true) {
    # Look for common Zscaler authentication window titles (including partial matches)
    $windowTitles = @(
        "Zscaler",
        "Authentication Required", 
        "Zscaler Client Connector",
        "Login Required",
        "ZCC Authentication",
        "Zscaler Sign In",
        "Sign In",
        "Authentication",
        "ZCC"
    )
    
    # Method 1: Direct window title matching
    foreach ($title in $windowTitles) {
        $hwnd = [Win32]::FindWindow($null, $title)
        if ($hwnd -ne [IntPtr]::Zero) {
            $hiddenCount++
            Write-Host "$(Get-Date): [Method 1] Hiding window: '$title' (Count: $hiddenCount)" -ForegroundColor Red
            [Win32]::ShowWindow($hwnd, [Win32]::SW_HIDE) | Out-Null
        }
    }
    
    # Method 2: Find all visible windows and check if they belong to Zscaler processes
    Get-Process -Name "*zsa*", "*zep*" -ErrorAction SilentlyContinue | ForEach-Object {
        $processId = $_.Id
        $processName = $_.ProcessName
        
        # Check if this process has any visible windows
        if ($_.MainWindowHandle -ne [IntPtr]::Zero -and $_.MainWindowTitle -ne "") {
            $windowTitle = $_.MainWindowTitle
            
            # Check if it's a Zscaler window that should be hidden
            $shouldHide = $windowTitles | Where-Object { $windowTitle -like "*$_*" -or $_ -like "*$windowTitle*" }
            
            if ($shouldHide) {
                $hiddenCount++
                Write-Host "$(Get-Date): [Method 2] Hiding $processName window: '$windowTitle' (Count: $hiddenCount)" -ForegroundColor Red
                [Win32]::ShowWindow($_.MainWindowHandle, [Win32]::SW_HIDE) | Out-Null
            }
        }
    }
    
    # Method 3: Aggressive search - hide any window with Zscaler-related keywords
    $zscalerKeywords = @("zscaler", "zcc", "authentication", "sign in", "login")
    
    Get-Process | Where-Object { $_.MainWindowTitle -ne "" } | ForEach-Object {
        $windowTitle = $_.MainWindowTitle.ToLower()
        $processName = $_.ProcessName.ToLower()
        
        # Check if window title or process name contains Zscaler keywords
        foreach ($keyword in $zscalerKeywords) {
            if (($windowTitle.Contains($keyword) -or $processName.Contains($keyword)) -and 
                ($processName.Contains("zsa") -or $processName.Contains("zep") -or $windowTitle.Contains("zscaler"))) {
                
                $hiddenCount++
                Write-Host "$(Get-Date): [Method 3] Hiding '$($_.ProcessName)' window: '$($_.MainWindowTitle)' (Count: $hiddenCount)" -ForegroundColor Red
                [Win32]::ShowWindow($_.MainWindowHandle, [Win32]::SW_HIDE) | Out-Null
                break
            }
        }
    }
    
    # Show status every 30 iterations (30 seconds)
    if ((Get-Date).Second % 30 -eq 0) {
        Write-Host "$(Get-Date): Still monitoring... (Hidden $hiddenCount popups so far)" -ForegroundColor Cyan
    }
    
    Start-Sleep -Seconds 1  # Faster checking - every 1 second instead of 2
}
