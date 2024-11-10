#!/bin/bash

# Exit on error
set -e

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - $1"
}

# Check if Google Chrome is installed, and install it if not
if ! command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &>/dev/null; then
    log_message "Google Chrome not found. Installing Google Chrome..."
    brew install --cask google-chrome
    log_message "Google Chrome installation completed."
else
    log_message "Google Chrome is already installed."
fi

# List of Chrome extensions to install (by extension ID)
# Replace these with the IDs of the extensions you want
EXTENSIONS=(
    "aapbdbdomjkkjkaonfhkkikfgjllcleb"  # Example: Google Translate
    "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # Example: uBlock Origin
    # Add more extension IDs here
)

# Install each Chrome extension by opening its URL in Chrome
for extension_id in "${EXTENSIONS[@]}"; do
    extension_url="https://chrome.google.com/webstore/detail/$extension_id"
    log_message "Installing extension from $extension_url"

    # Open the extension's URL in Chrome to prompt manual installation
    chrome-cli open "$extension_url"

    log_message "Opened installation page for extension ID: $extension_id"
done

log_message "All specified extensions have been opened for installation."
