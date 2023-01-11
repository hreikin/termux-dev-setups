#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Download minimal install script.
wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/scripts/base.sh
chmod +x base.sh
source base.sh


# Enable X11 repository.
echo "Enabling X11 and TUR repositories."
pkg install -y x11-repo tur-repo

# Install required dependencies
echo "Installing XFCE desktop and basic packages."
pkg install -y code-oss firefox leafpad python python-tkinter tigervnc xclip xfce4 xfce4-terminal

# Configuring VNC server.
echo """Configuring VNC server.
When prompted please provide a VNC password. Note that passwords are not visible when you are typing them and maximum password length is 8 characters."""
sleep 2
vncserver -localhost
echo "xfce4-session &" > $HOME/.vnc/xstartup
echo "geometry=1920x1080" >> $HOME/.vnc/config
echo "export DISPLAY=\":1\"" >> $HOME/.bashrc
vncserver -kill :1
