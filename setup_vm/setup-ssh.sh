#!/bin/bash

authorized_keys_file="$HOME/.ssh/authorized_keys"
additional_key="enter ssh key here and uncomment function in Vagrant file"

if [[ -e "$authorized_keys_file" ]]; then
    echo "File $authorized_keys_file already exists. Appending text."
    echo "$additional_key" >> "$authorized_keys_file"
     # Check if the .ssh directory exists, create it if not
elif [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo "Created .ssh directory."


    # Check if the authorized_keys file exists, create it if not
    if [ ! -f "$authorized_keys_file" ]; then
        touch "$authorized_keys_file"
        chmod 600 "$authorized_keys_file"
        echo "Created authorized_keys file."
    fi

    # Add the public key to authorized_keys
    echo "$additional_key" >> "$authorized_keys_file"
    echo "Added public key to authorized_keys."
    echo "Script execution complete."
fi    