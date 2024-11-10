#!/bin/bash

# Exit on error
set -e

# Configuration
LOG_FILE="script_execution.log"
SCRIPTS_DIR="./scripts"  # Directory containing Bash scripts

# Create log file if it doesn't exist
touch "$LOG_FILE"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] - $1" | tee -a "$LOG_FILE"
}

# Function to run a Bash script
run_bash_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path")

    if [ -f "$script_path" ]; then
        log_message "Starting execution of $script_name"

        if bash "$script_path" "${@:2}"; then  # Run the script with additional arguments
            log_message "Successfully executed $script_name"
            return 0
        else
            log_message "Error executing $script_name"
            return 1
        fi
    else
        log_message "Error: Script $script_path not found"
        return 1
    fi
}

# Create scripts directory if it doesn't exist
mkdir -p "$SCRIPTS_DIR"

# Example: Run multiple scripts in sequence
for script in "$SCRIPTS_DIR"/*.sh; do
    run_bash_script "$script"
done