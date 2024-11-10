#!/bin/bash

# Exit on error
set -e

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Detect the shell and set the appropriate configuration file
if [[ "$SHELL" == *"zsh"* ]]; then
    CONFIG_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    log_message "Unsupported shell. This script only supports Zsh and Bash."
    exit 1
fi

log_message "Using configuration file: $CONFIG_FILE"

# Define aliases to add
ALIASES=(
    "alias ll='ls -la'"                  # Detailed list view
    "alias gs='git status'"              # Short for 'git status'
    "alias gp='git pull'"                # Short for 'git pull'
    "alias gc='git commit -m'"           # Short for 'git commit'
    "alias v='vim'"                      # Short for 'vim'
    "alias ..='cd ..'"                   # Go up one directory
    "alias ...='cd ../..'"               # Go up two directories
    "alias h='history'"                  # Show command history
)

# Add each alias to the configuration file if not already present
for alias_cmd in "${ALIASES[@]}"; do
    if ! grep -Fxq "$alias_cmd" "$CONFIG_FILE"; then
        echo "$alias_cmd" >> "$CONFIG_FILE"
        log_message "Added alias: $alias_cmd"
    else
        log_message "Alias already exists: $alias_cmd"
    fi
done

# Source the configuration file to apply changes
log_message "Applying changes..."
source "$CONFIG_FILE"
log_message "All aliases added and changes applied. Restart the terminal or run 'source $CONFIG_FILE' if needed."
