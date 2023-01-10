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

# Enable the tur-repository.
pkg install -y tur-repo

# Install minimal set of packages.
pkg install -y curl git htop micro openssh code-server

# Configuring Micro code editor and installing plugins.
echo "Configuring Micro code editor and installing plugins."
micro -plugin install autofmt detectindent filemanager manipulator quoter snippets

# Set filemanager plugin to show by default.
sed -i '/config.RegisterCommonOption("filemanager", "openonstart", false)/c\config.RegisterCommonOption("filemanager", "openonstart", true)' $HOME/.config/micro/plug/filemanager/filemanager.lua

# Autostart code-server when termux is launched.
echo "Configuring code-server to run when termux is launched."
echo "code-server > code-server.log 2>&1 &" >> $HOME/.bashrc
