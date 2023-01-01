#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Print welcome message.
echo "This script configures termux and installs a minimal XFCE based development environment."
echo "A full list of installed packages can be found within the Github repository."

# Update and upgrade termux
echo "Updating packages."
pkg update -y && pkg upgrade -y

# Setup mirrors.
echo "Please select/configure your mirrors."
termux-change-repo

# Setup storage permissions.
echo "Creating user directories and setting up storage permissions."
echo "Please grant termux storage permissions."
termux-setup-storage

# Create and link user directories.
mkdir $HOME/Desktop 
mkdir $HOME/Downloads 
mkdir $HOME/Templates 
mkdir $HOME/Public 
mkdir $HOME/Documents 
mkdir $HOME/Pictures 
mkdir $HOME/Videos
mkdir $HOME/Music
ln -s $HOME/storage/music $HOME/Music
ln -s $HOME/storage/downloads $HOME/Downloads
ln -s $HOME/storage/dcim $HOME/Pictures

# Enable X11 repository.
echo "Enabling X11 repository."
pkg install -y x11-repo

# Install required dependencies
echo "Installing minimal set of packages."
pkg install -y binutils build-essential curl firefox git htop micro python python-tkinter tigervnc wget xclip xfce4 xfce4-terminal

# Configuring VNC server.
echo "Configuring VNC server."
echo "When prompted please provide a VNC password."
echo "Note that passwords are not visible when you are typing them and maximum password length is 8 characters."
vncserver -localhost
echo "xfce4-session &" > $HOME/.vnc/xstartup
echo "geometry=1920x1080" >> $HOME/.vnc/config
echo "export DISPLAY=":1"" >> $HOME/.bashrc
vncserver -kill :1

# Configuring Micro code editor and installing plugins.
echo "Configuring Micro code editor and installing plugins."
micro -plugin install autofmt detectindent filemanager manipulator quoter snippets

# Set filemanager plugin to show by default.
sed -i '/config.RegisterCommonOption("filemanager", "openonstart", false)/c\config.RegisterCommonOption("filemanager", "openonstart", true)' $HOME/.config/micro/plug/filemanager/filemanager.lua

# Confirm successful installation and exit.
echo "Installation complete."
echo 'To start the VNC server enter "vncserver".'
echo 'To stop the VNC server enter "vncserver -kill :1".'
exit
