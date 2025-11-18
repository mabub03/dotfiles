#!/bin/bash

# Directory to monitor
MONITOR_DIR="$HOME/Pictures"

# Destination directory
DEST_DIR="$HOME/Pictures/Screenshots/"

# Pattern to match
PATTERN="Screenshot_*.png"

# --- Initial scan for existing files ---
echo "Running initial scan for existing screenshots in $MONITOR_DIR..."
find "$MONITOR_DIR" -maxdepth 1 -type f -name "$PATTERN" -print0 | while IFS= read -r -d $'\0' FILE_PATH
do
    FILE=$(basename "$FILE_PATH") # Get just the filename
    if [[ -f "$FILE_PATH" ]]; then # Double check if the file still exists
        /usr/bin/mv "$FILE_PATH" "$DEST_DIR"
        echo "Moved existing $FILE to $DEST_DIR"
    fi
done
echo "Initial scan complete."


# Use inotifywait to monitor the directory
inotifywait -m -e create -e moved_to --format "%f" "$MONITOR_DIR" | while read FILE
do
    if [[ "$FILE" == $PATTERN ]]
    then
        mv "$MONITOR_DIR/$FILE" "$DEST_DIR"
        echo "Moved $FILE to $DEST_DIR"
    fi
done
