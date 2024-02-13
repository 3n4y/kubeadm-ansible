#!/bin/bash

authorized_keys_file="$HOME/.ssh/authorized_keys"
additional_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRvaAlltmAtQVZwXkTkjSQ2GDbLBi1KIu15TQ2X2H8UPR+hnKB2tmxgCZ7CmbcRXNzg+brNZ8Y221UTaUuVm/kpV1Dp0Qn8xP9rQNopeSQ/a79HXtCqWg8Bo3ON7I5aiu1dqmW/8Du8IV1Yi1KzQUHWGLhIxZSQHdex9bOj3cAiogmZ7SoBzzms6MjR800xpdsDjHvN8xQmCVvCwM7yRNUO5bPVc7FDAiaCAzQJ02Au9Ac+fM8zaQSYXfYA+7/jwSm8LF0eOPA3XbNr5fTc5r/lzodJt5iRsiAJRViQMyOabS6HoE3oAExng9sD2gyV3f+74OxJMkKXyIujNO11RcfNteghx6zA/SRbffUE9IpTtSGklQjZhz8l0AqXyjikWvjgjPUgYi4K2HJmMKcjRq/hJIEUCnoOf9lgyfQC613sMu4Xo0aeV7VmCG2CK3v5bk+GBP/G1hgzg7PDuKzi43W5sRs3P0XI2gX7HvCahEgOrF4xAbzGZJ9MaPS7EPYbRk= ndudi@ndudi-VirtualBox"

if [[ -e "$authorized_keys_file" ]]; then
    echo "File $authorized_keys_file already exists. Appending text."
    echo "$additional_key" >> "$authorized_keys_file"
else
    echo "Creating file $authorized_keys_file and writing text to it."
    echo "$additional_key" > "$authorized_keys_file"
    chmod 600 "$authorized_keys_file"  # Set appropriate permissions
fi

echo "Script execution complete."