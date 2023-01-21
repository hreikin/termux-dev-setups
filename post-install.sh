#!/data/data/com.termux/files/usr/bin/bash

## Author  : Michael Haslam
## Mail    : hreikin@gmail.com
## License : MIT

# Fail on error and report it, debug all lines.
set -eu -o pipefail

config_git_user () {
    echo
    echo "This step configures your git user.name with the following command:"
    echo
    echo -e "git config --global user.name \"Example Name\""
    echo
    read -p "Please enter your git user.name: " USER_NAME
    git config --global user.name "$USER_NAME"
}

config_git_email () {
    echo
    echo "This step configures your git user.email with the following command:"
    echo
    echo -e "git config --global user.email \"example@example.com\""
    echo
    read -p "Please enter your git user.email: " USER_EMAIL
    git config --global user.email "$USER_EMAIL"
}

generate_ssh_key () {
    echo
    echo "This step generates an SSH key nd adds it to the SSH agent with the following commands:"
    echo
    echo -e "ssh-keygen -t ed25519 -C \"example@example.com\""
    echo -e "eval \"\$(ssh-agent -s)\""
    echo -e "ssh-add ~/.ssh/id_ed25519"
}

# Change to $HOME directory before starting.
cd $HOME
echo "This script takes care of a few common post-installation tasks such as:"
echo
echo "- Configuring git user.name"
echo "- Configuring git user.email"
echo "- Generating a default SSH key"
config_git_user
config_git_email
generate_ssh_key
