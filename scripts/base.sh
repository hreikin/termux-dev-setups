#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Setup storage permissions.
echo """Setting up required storage permissions.
Please grant termux storage permissions."""
termux-setup-storage
sleep 2

# Setup mirrors.
echo "Please select/configure your default mirrors."
sleep 2
termux-change-repo

# Update and upgrade termux, install termux-api package.
echo "Updating packages and installing termux-api."
pkg update -y && pkg upgrade -y
pkg install -y termux-api

# Create and link user directories.
mkdir $HOME/Desktop 
mkdir $HOME/Downloads 
mkdir $HOME/Templates 
mkdir $HOME/Public 
mkdir $HOME/Documents 
mkdir $HOME/Pictures 
mkdir $HOME/Videos
mkdir $HOME/Music
ln -s $HOME/storage/music/ $HOME/Music
ln -s $HOME/storage/downloads/ $HOME/Downloads
ln -s $HOME/storage/dcim/ $HOME/Pictures