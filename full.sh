#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Download minimal install script.
wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/minimal.sh?token=GHSAT0AAAAAAB46CJR7ZI64PDX7ALYUDWSIY5R7BPQ
chmod +x minimal.sh
source minimal.sh

# Print welcome message and install extra packages.
echo """Full installation starting.
Installing extra packages."""
pkg install -y 

# Confirm successful installation and exit.
echo '''Full installation complete.
To start the VNC server enter "vncserver".
To stop the VNC server enter "vncserver -kill :1".'''
sleep 2
exit
