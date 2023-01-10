#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

# Create dialog menu for option selection.
TERMINAL=$(tty)
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="termux-dev-setups"
TITLE="Installation"
MENU="Please choose one of the following options:"

OPTIONS=(1 "Minimal"
         2 "Desktop")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >$TERMINAL)

clear
case $CHOICE in
        1)
            clear
            echo "Starting minimal installation."
            # Download minimal install script.
            wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/scripts/minimal.sh
            chmod +x minimal.sh
            source minimal.sh
            echo "Minimal installation is now complete."
            ;;
        2)
            clear
            echo "Starting desktop installation."
            # Download desktop install script.
            wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/scripts/desktop.sh
            chmod +x desktop.sh
            source desktop.sh
            echo "Desktop installation is now complete."
            ;;
esac