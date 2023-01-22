#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

config_base () {
    # Setup storage permissions.
    echo "Setting up required storage permissions."
    echo "Please grant termux storage permissions."
    termux-setup-storage
    sleep 2

    # Setup mirrors.
    echo "Please select/configure your default mirrors."
    sleep 2
    termux-change-repo

    # Update and upgrade termux, install termux-api package.
    echo "Updating and installing base packages."
    pkg update -y && pkg upgrade -y
    pkg install -y binutils build-essential curl git htop nano ncurses-utils openssh termux-api

    # Create and link user directories.
    mkdir "$HOME"/Desktop
    mkdir "$HOME"/Downloads
    mkdir "$HOME"/Templates
    mkdir "$HOME"/Public
    mkdir "$HOME"/Documents
    mkdir "$HOME"/Pictures
    mkdir "$HOME"/Videos
    mkdir "$HOME"/Music
    ln -s "$HOME"/storage/music/ "$HOME"/Music
    ln -s "$HOME"/storage/downloads/ "$HOME"/Downloads
    ln -s "$HOME"/storage/dcim/ "$HOME"/Pictures

    # Add custom PS1 to bashrc.
    echo "# Custom PS1 prompt." >> "$HOME"/.bashrc
    echo "export PS1=\"\[\033[38;5;11m\]\u\[$(tput sgr0)\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]: \[$(tput sgr0)\]\"" >> "$HOME"/.bashrc
}

config_minimal () {
    # Enable the tur-repository.
    pkg install -y tur-repo
    pkg update -y && pkg upgrade -y

    # Install minimal set of packages.
    pkg install -y micro code-server

    # Configuring Micro code editor and installing plugins.
    echo "Configuring Micro code editor and installing plugins."
    micro -plugin install autofmt detectindent filemanager manipulator quoter snippets

    # Set filemanager plugin to show by default.
    sed -i '/config.RegisterCommonOption("filemanager", "openonstart", false)/c\config.RegisterCommonOption("filemanager", "openonstart", true)' "$HOME"/.config/micro/plug/filemanager/filemanager.lua
}

config_desktop () {
    # Enable X11 repository.
    echo "Enabling X11 repository."
    pkg install -y x11-repo
    pkg update -y && pkg upgrade -y

    # Install required dependencies
    echo "Installing XFCE desktop and basic packages."
    pkg install -y code-oss firefox leafpad python python-tkinter xclip xfce4 xfce4-terminal
}

config_vnc () {
    # Update and install tigervnc.
    pkg update -y && pkg upgrade -y
    pkg install -y tigervnc

    # Configuring VNC server.
    echo "Configuring VNC server."
    echo "When prompted please provide a VNC password. Note that passwords are not visible when you are typing them and maximum password length is 8 characters."
    vncserver -localhost
    echo "#!/data/data/com.termux/files/usr/bin/sh" > "$HOME"/.vnc/xstartup
    echo "xfce4-session &" >> "$HOME"/.vnc/xstartup
    echo "geometry=1920x1080" >> "$HOME"/.vnc/config
    echo "# VNC display variable." >> "$HOME"/.bashrc
    echo "export DISPLAY=\":1\"" >> "$HOME"/.bashrc
    vncserver -kill :1
}

config_xserver () {
    echo "Configuring Xserver."
    echo "# Xserver display variable." >> "$HOME"/.bashrc
    echo "export DISPLAY=localhost:0" >> "$HOME"/.bashrc
}

# Minimal and desktop installation completed messages.
MINIMAL_MSG="
Minimal installation is now complete.

Code Server Instructions
To start code-server use the following command:

code-server &

This will run code-server in the background and generate a default config.yaml file on first run.
The password used to access code-server in the browser can be found using the config.yaml file
available at:

~/.config/code-server/config.yaml

Next open a browser and go to the following address:

https//127.0.0.1:8080

Detailed usage instructions can be found at the following github repository:

https://githb.com/hreikin/termux-dev-setups

Please quit Termux using the 'exit' command and then restart the app.
"
DESKTOP_VNC_MSG="
Desktop installation is now complete. To view the installed desktop you will need to use a VNC
viewer installed on Android.

VNC Instructions
To start the VNC server use the following command:

vncserver

To view running VNC servers use the following command:

vncserver -list

To stop a VNC server running on display 1 use the following command:

vncserver -kill :1

Detailed usage instructions can be found at the following github repository:

https://githb.com/hreikin/termux-dev-setups

Please quit Termux using the 'exit' command and then restart the app.
"
DESKTOP_XSERVER_MSG="
Desktop installation is now complete. To view the installed desktop you will need to use an Xserver
client installed on Android.

Xserver Instructions
To start the XFCE desktop run one of the following commands:

startxfce4 &
xfce4-session &

Then open your Xserver app on Android to view the desktop.

You can also launch single applications such as code-oss or firefox like so:

xfwm4 & code-oss
xfwm4 & firefox

Detailed usage instructions can be found at the following github repository:

https://githb.com/hreikin/termux-dev-setups

Please quit Termux using the 'exit' command and then restart the app.
"

# Create dialog menu for option selection.
TERMINAL=$(tty)
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="termux-dev-setups"
TITLE="Installation"
MENU="Please choose one of the following options, use the ARROW keys to navigate and press ENTER to select your option:"

OPTIONS=(1 "Minimal"
         2 "Desktop (VNC)"
         3 "Desktop (Xserver)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >"$TERMINAL")

clear
case $CHOICE in
        1)
            clear
            echo "Starting \"Minimal\" installation."
            config_base
            config_minimal
            source "$HOME"/.bashrc
            clear
            echo "$MINIMAL_MSG"
            ;;
        2)
            clear
            echo "Starting \"Desktop (VNC)\" installation."
            config_base
            config_minimal
            config_desktop
            config_vnc
            source "$HOME"/.bashrc
            clear
            echo "$DESKTOP_VNC_MSG"
            ;;
        3)
            clear
            echo "Starting \"Desktop (Xserver)\" installation."
            config_base
            config_minimal
            config_desktop
            config_xserver
            source "$HOME"/.bashrc
            clear
            echo "$DESKTOP_XSERVER_MSG"
            ;;
esac
