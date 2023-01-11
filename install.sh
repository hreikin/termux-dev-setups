#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT
{
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
            source $HOME/.bashrc
            clear
            echo """Minimal installation is now complete.
            
            
            Code Server Instructions
            To start code-server use the following command:
            
            code-server
            
            Then open a browser and go to the following address:
            
            https//127.0.0.1:8080
            
            The password used to access code-server in the browser can be configured using the config.yaml file available at:
            
            ~/.config/code-server/config.yaml
            
            Please quit Termux using the 'exit' command and then restart the app."""
            ;;
        2)
            clear
            echo "Starting desktop installation."
            # Download desktop install script.
            wget https://raw.githubusercontent.com/hreikin/termux-dev-setups/main/scripts/desktop.sh
            chmod +x desktop.sh
            source desktop.sh
            source $HOME/.bashrc
            clear
            echo """Desktop installation is now complete. To view the installed desktop you will need to use a VNC viewer installed on Android.


            VNC Instructions
            To start the VNC server use the following command:
            
            vncserver
            
            To view running VNC servers use the following command:
            
            vncserver -list
            
            To stop a VNC server running on display 1 use the following command:
            
            vncserver -kill :1
            
            Please quit Termux using the 'exit' command and then restart the app."""
            ;;
esac
} > tds-install.log