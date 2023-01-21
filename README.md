# Termux Developer Setups
An easy to use script for installation of a simple developer setup in termux.

## Requirements
- No root permission is required to make this work
- Android 7+ phone
- VNC or Xserver client on phone
- Termux installed from F-Droid
- TermuxAPI installed from F-Droid

> **NOTE**: Termux from Google Play is unmaintained due to API requirements, please use F-Droid instead.

## Installation
To start the installation follow the steps below.

```
pkg update -y && pkg upgrade -y
pkg install wget
wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/install.sh
chmod +x install.sh
./install.sh
```

### Installation Options

- **Minimal** - A minimal installation with `code-server` and the `Micro` code editor installed.
- **Desktop (VNC)** - An XFCE desktop environment accessible via VNC with everything from the Minimal install plus `code-oss`, `leafpad` and `firefox` installed.
- **Desktop (Xserver)** - An XFCE desktop environment accessible via Xserver with everything from the Minimal install plus `code-oss`, `leafpad` and `firefox` installed.
