#!/bin/bash

authorized_keys_file="$HOME/.ssh/authorized_keys"
additional_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzaokV1578cG+21k3dXduPZqkwcZXNEKJUaldAX6ovaN0IQ0743YqhdNwdcL3gWT2bJ5zBBjSXnCUpTshT107tNqHQnO5Na6rSM/Vh5kdr5mGZx5IP1KUq+fjzuZS+d+kHRU2C1ySZBPayNUuDn51g7VZBrVDx3Z8sjgZTI+uf1OISndSurt6Zk708d/GtkFRXRiUomSzuyEvLvKcD6NyIeUorbxN7qCL0LNa5pqrD8xVxqhCtanY2DrLiQGMy6vBw4IdJliZLEDuYbVxazgjRDYxE8yDG3hiVJbttjq5jHYuzAQBaXa4HCB548OczRxuIjrXECW7y/rd2cVtG+spn endy.obiki@lldevkl-eobiki.office.globalrelay.net"

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