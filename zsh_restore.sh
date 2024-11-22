#!/bin/bash

# Define paths
HISTORY_FILE="$HOME/.zsh_history"
BACKUP_DIR="$HOME/.zsh_history_backups"

# Find the most recent backup
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/zsh_history_* 2>/dev/null | head -n 1)

# Restore the most recent backup
if [ -n "$LATEST_BACKUP" ]; then
    cp "$LATEST_BACKUP" "$HISTORY_FILE"
    echo "Restored history from $LATEST_BACKUP"

    # Delete all other backups
    find "$BACKUP_DIR" -type f -not -name "$(basename "$LATEST_BACKUP")" -exec rm {} +
    echo "Deleted all older backups."
else
    echo "No backups found to restore."
fi

