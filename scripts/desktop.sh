#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Download minimal install script.
wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/scripts/minimal.sh
chmod +x minimal.sh
source minimal.sh


# Enable X11 repository.
echo "Enabling X11 repository."
pkg install -y x11-repo

# Install required dependencies
echo "Installing minimal set of packages."
pkg install -y binutils build-essential code-oss firefox leafpad python python-tkinter tigervnc xclip xfce4 xfce4-terminal

# Configuring VNC server.
echo """Configuring VNC server.
When prompted please provide a VNC password. Note that passwords are not visible when you are typing them and maximum password length is 8 characters."""
sleep 2
vncserver -localhost
echo "xfce4-session &" > $HOME/.vnc/xstartup
echo "geometry=1920x1080" >> $HOME/.vnc/config
echo "export DISPLAY=":1"" >> $HOME/.bashrc
vncserver -kill :1
