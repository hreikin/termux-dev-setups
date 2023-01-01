#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Download minimal install script.
wget https://github.com/hreikin/termux-dev-setups/minimal.sh
source minimal.sh

# Print welcome message.
echo """Full installation starting.
Installing required packages."""


# Confirm successful installation and exit.
echo '''Full installation complete.
To start the VNC server enter "vncserver".
To stop the VNC server enter "vncserver -kill :1".'''
sleep 2
exit
