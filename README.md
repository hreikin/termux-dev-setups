# Termux Developer Setups
An easy to use script for installation of a simple developer setup in termux.

## Requirements
- No root permission is required to make this work
- Android 7+ phone
- VNC or Xserver client on phone (bVNC or XserverXSDL)
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

## Usage

Below are some basic usage examples for each type of installation.

### Minimal

To start code-server use the following command:

```
code-server &
```

This will run code-server in the background and generate a default config.yaml file on first run. The password used to access code-server in the browser can be found using the config.yaml file available at:

```
~/.config/code-server/config.yaml
```

Next open a browser on Android (I recommend Kiwi Browser if doing Web Development because it comes with the developer console but Firefox, Chrome, etc will work perfectly as well.) and go to the following address:

```
https//127.0.0.1:8080
```
### Desktop (VNC)

To view the installed desktop you will need to use a VNC viewer installed on Android. I recommend bVNC.

To start the VNC server use the following command:

```
vncserver
```

To view running VNC servers use the following command:

```
vncserver -list
```

To stop a VNC server running on display 1 use the following command:

```
vncserver -kill :1
```

### Desktop (Xserver)

To view the installed desktop you will need to use an Xserver
client installed on Android. I recommend Xserver XSDL.

To start the XFCE desktop run one of the following commands:

```
startxfce4 &
xfce4-session &
```

Then open your Xserver app on Android to view the desktop.

You can also launch single applications such as code-oss or firefox like so:

```
xfwm4 & code-oss
xfwm4 & firefox
```

### Post Installation

The script `post-install.sh` is a small convenience script which handles a few tasks such as:

- Configuring git user.name
- Configuring git user.email
- Configuring git core.editor to use `nano`
- Generate an SSH key and add it to the SSH agent

To use it once you have succesfully installed your developer setup run the following commands:

```
wget https://raw.githbusercontent.com/hreikin/termux-dev-setups/main/post-install.sh
chmod +x post-install.sh
./post-install.sh
```
