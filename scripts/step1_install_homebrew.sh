#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - $1"
}

# Check if Homebrew is installed, and install it if not
if ! command -v brew &>/dev/null; then
    log_message "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_message "Homebrew installation completed."
else
    log_message "Homebrew is already installed."
fi

# List of packages to install
PACKAGES=(
    git
    wget
    node
    python3
    chrome-cli
)

# Function to install a package
install_package() {
    local package="$1"
    if brew list "$package" &>/dev/null; then
        log_message "$package is already installed."
    else
        log_message "Installing $package..."
        brew install "$package"
        log_message "$package installation completed."
    fi
}

# Install each package in the list
for package in "${PACKAGES[@]}"; do
    install_package "$package"
done

log_message "All specified packages are installed."
