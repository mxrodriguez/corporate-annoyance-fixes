# 🛡️ Zscaler Popup Ninja

> *Stealthily eliminating annoying authentication popups since 2025*

[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)](https://docs.microsoft.com/en-us/powershell/)
[![Windows](https://img.shields.io/badge/Windows-0078D4?style=flat&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🎯 What This Does

Tired of Zscaler's authentication popups interrupting your workflow? This PowerShell script is your digital ninja - it silently hunts down those pesky authentication windows and makes them vanish into the void. No more clicking "Cancel" every 30 seconds or losing focus from your important work!

**Problem Solved**: Corporate environments often have Zscaler configured with persistent authentication prompts that can appear every few minutes, disrupting productivity and breaking concentration.

## ⚡ Features

- **🥷 Stealth Mode**: Hides authentication popups without killing processes (no restart loops!)
- **🎯 Multi-Target**: Hunts multiple window titles that Zscaler might use
- **🔄 Continuous Monitoring**: Runs in the background, always watching
- **⚡ Lightning Fast**: Checks every 2 seconds for maximum responsiveness
- **🪟 Windows API**: Uses native Win32 API for reliable window manipulation
- **💾 Zero Persistence**: No files created, no registry changes, no traces left behind
- **🚀 Instant Start**: Ready to run - no installation or configuration required

## 🚀 Quick Start

### Option 1: Direct Download
```powershell
# Download and run immediately
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mxrodriguez/corporate-annoyance-fixes/master/hide_zscaler_popup.ps1" -OutFile "hide_zscaler_popup.ps1"
.\hide_zscaler_popup.ps1
```

### Option 2: Clone Repository
```powershell
# Clone the repo
git clone https://github.com/mxrodriguez/corporate-annoyance-fixes.git
cd corporate-annoyance-fixes

# Run the script
.\hide_zscaler_popup.ps1
```

**That's it!** The script will start monitoring and automatically hide any Zscaler authentication popups. Press `Ctrl+C` to stop.

### 🔧 Auto-Start on Boot (Optional)
To run automatically when Windows starts:

1. Press `Win + R`, type `shell:startup`, press Enter
2. Create a batch file called `zscaler_ninja.bat` with:
```batch
@echo off
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\path\to\hide_zscaler_popup.ps1"
```
3. Place the batch file in the startup folder

## 🔧 How It Works

The script leverages Windows API calls to:

1. **Scan** for authentication windows using common Zscaler window titles
2. **Locate** the window handles using `FindWindow` API
3. **Hide** the windows using `ShowWindow` API with `SW_HIDE` flag
4. **Repeat** the process every 2 seconds

### Targeted Window Titles:
- Zscaler
- Authentication Required
- Zscaler Client Connector
- Login Required
- ZCC Authentication
- Zscaler Sign In

## 🛠️ Technical Details

- **Language**: PowerShell with C# Win32 API interop
- **Requirements**: Windows PowerShell 5.1+ or PowerShell Core 6+
- **Privileges**: Runs in user context (no admin required)
- **Memory Footprint**: Minimal - only monitors, doesn't store data

## 🛠️ Troubleshooting

### Script Not Finding Popups?
1. **Check window titles**: Run `Get-Process | Where-Object {$_.MainWindowTitle -ne ""} | Select-Object Name, MainWindowTitle` to see active window titles
2. **Add custom titles**: Edit the `$windowTitles` array in the script to include your specific popup titles
3. **Test manually**: Try `[Win32]::FindWindow($null, "Your Window Title")` to test detection

### Execution Policy Issues?
```powershell
# Run this first if you get execution policy errors
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

### Still Getting Popups?
- **Verify the script is running**: Look for "Monitoring for Zscaler authentication windows" message
- **Check for new popup titles**: Zscaler might use different window titles than expected
- **Run with admin privileges**: Some corporate environments may require elevated permissions

## ⚙️ Important Notes

- 🔒 This script **hides** popups rather than disabling Zscaler entirely
- 🔄 Zscaler services continue running normally in the background
- 🏢 Corporate IT policies may require Zscaler authentication - use responsibly
- 🔒 The script doesn't interfere with actual network security functions
- ⚠️ Use at your own discretion - some organizations prohibit bypassing security prompts

## 📊 What's in This Repository

```
corporate-annoyance-fixes/
├── hide_zscaler_popup.ps1    # The main popup-hiding script
├── README.md                # This documentation
└── calibre                  # Other configuration files
```

## 🤝 Contributing

**Found a bug or improvement?** Contributions welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-improvement`)
3. Make your changes
4. Test thoroughly
5. Commit changes (`git commit -m 'Add amazing improvement'`)
6. Push to branch (`git push origin feature/amazing-improvement`)
7. Open a Pull Request

**Ideas for contributions:**
- 🎯 Add detection for more popup titles
- 🔇 Add quiet/silent mode option
- 📅 Add logging functionality
- 🎨 Improve the user interface
- 🛠️ Add configuration file support

## 📝 License

**MIT License** - Free to use, modify, and share!

No warranty provided - use at your own risk. This tool is for educational and productivity purposes.

## 👤 Author

**Michael Rodriguez** ([@mxrodriguez](https://github.com/mxrodriguez))

*Built with ☕ and frustration at authentication popups*

---

🚀 **Star this repo** if it saved you from popup frustration!

📧 **Found this helpful?** Consider sharing it with colleagues who face the same Zscaler popup annoyance!
