# 🛡️ Zscaler Popup Ninja

> *Stealthily eliminating annoying authentication popups since 2025*

## 🎯 What This Does

Tired of Zscaler's authentication popups interrupting your flow? This PowerShell script is your digital ninja - it silently hunts down those pesky authentication windows and makes them vanish into the void. No more clicking "Cancel" every 30 seconds!

## ⚡ Features

- **🥷 Stealth Mode**: Hides authentication popups without killing processes (no restart loops!)
- **🎯 Multi-Target**: Hunts multiple window titles that Zscaler might use
- **🔄 Continuous Monitoring**: Runs in the background, always watching
- **⚡ Lightning Fast**: Checks every 2 seconds for maximum responsiveness
- **🪟 Windows API**: Uses native Win32 API for reliable window manipulation

## 🚀 Quick Start

```powershell
# Clone the repo
git clone https://github.com/mxrodriguez/dotfiles.git
cd dotfiles

# Run the script
.\hide_zscaler_popup.ps1
```

**That's it!** The script will start monitoring and automatically hide any Zscaler authentication popups. Press `Ctrl+C` to stop.

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

## ⚠️ Important Notes

- This script **hides** popups rather than disabling Zscaler entirely
- Zscaler services continue running normally in the background
- Corporate IT policies may require Zscaler authentication - use responsibly
- The script doesn't interfere with actual network security functions

## 🤝 Contributing

Found a new Zscaler popup title that isn't caught? Want to improve the script? Pull requests welcome!

## 📝 License

Free to use, modify, and share. No warranty provided - use at your own risk!

---

*Built with ☕ and frustration at authentication popups*

> **Pro Tip**: Add this script to your Windows startup if you want it to run automatically when you boot up your machine!
