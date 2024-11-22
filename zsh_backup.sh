#!/bin/bash

# Define paths
HISTORY_FILE="$HOME/.zsh_history"
BACKUP_DIR="$HOME/.zsh_history_backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/zsh_history_$TIMESTAMP"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup history
if [ -f "$HISTORY_FILE" ]; then
    cp "$HISTORY_FILE" "$BACKUP_FILE"
    echo "Backup created at $BACKUP_FILE"
else
    echo "No .zsh_history file to back up."
fi

# Clear the history file
> "$HISTORY_FILE"
echo "History file wiped."

# Get the PID of the parent shell's terminal process
PARENT_SHELL_PID=$(ps -o ppid= -p $$ | tr -d ' ')
# Forcefully kill the parent shell process to prevent saving history
echo "Forcefully killing zsh (to prevent history from being saved)..."
echo "Please close this window manually."
kill -9 "$PARENT_SHELL_PID"
