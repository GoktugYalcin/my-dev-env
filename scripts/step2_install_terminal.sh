#!/bin/bash

# Exit on error
set -e

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Install iTerm2 using Homebrew
if ! command -v /Applications/iTerm.app &>/dev/null; then
    log_message "iTerm2 not found. Installing iTerm2..."
    brew install --cask iterm2
    log_message "iTerm2 installation completed."
else
    log_message "iTerm2 is already installed."
fi

# Install Zsh if it's not installed (Zsh is usually pre-installed on macOS)
if ! command -v zsh &>/dev/null; then
    log_message "Zsh not found. Installing Zsh..."
    brew install zsh
    log_message "Zsh installation completed."
else
    log_message "Zsh is already installed."
fi

# Set Zsh as the default shell if it’s not already
if [[ "$SHELL" != "$(which zsh)" ]]; then
    log_message "Setting Zsh as the default shell..."
    chsh -s "$(which zsh)"
    log_message "Zsh has been set as the default shell."
else
    log_message "Zsh is already the default shell."
fi

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_message "Oh My Zsh not found. Installing Oh My Zsh..."
    # Run the official Oh My Zsh installation command
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log_message "Oh My Zsh installation completed."
else
    log_message "Oh My Zsh is already installed."
fi

log_message "iTerm2, Zsh, and Oh My Zsh setup completed successfully."
