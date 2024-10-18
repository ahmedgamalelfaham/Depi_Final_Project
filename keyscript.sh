#!/bin/bash

# Set default values (you can modify these or make them arguments to the script)
KEY_NAME="id_rsa"                     # Name for the SSH key
KEY_DIR="$HOME/.ssh"                  # Directory where keys will be stored
KEY_PATH="$KEY_DIR/$KEY_NAME"         # Full path to the private key
KEY_COMMENT="user@hostname"           # Comment for the key (usually user@hostname)
PASSPHRASE=""                         # Passphrase for the key (leave empty for no passphrase)

# Check if the .ssh directory exists, if not, create it
if [ ! -d "$KEY_DIR" ]; then
    echo "Creating .ssh directory at $KEY_DIR"
    mkdir -p "$KEY_DIR"
    chmod 700 "$KEY_DIR"
fi

# Remove existing keys if they already exist to avoid overwrite prompt
if [ -f "$KEY_PATH" ]; then
    echo "Removing existing key at $KEY_PATH"
    rm -f "$KEY_PATH" "$KEY_PATH.pub"
fi

# Generate the SSH key pair
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -C "$KEY_COMMENT" -N "$PASSPHRASE"

# Optionally, output the public key
echo "Your public key is:"
cat "${KEY_PATH}.pub"

# Change permissions of the key files (optional but recommended)
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo "SSH key pair generated and stored in $KEY_DIR"
