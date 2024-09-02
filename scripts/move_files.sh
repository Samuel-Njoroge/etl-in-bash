#!/bin/bash

# Set source and destination directories
SOURCE_DIR="../mixed_files"
DEST_DIR="json_and_CSV"

# Create destination directory
mkdir -p "$DEST_DIR"

# Move CSV and JSON files
echo "Moving CSV and JSON files..."
find "$SOURCE_DIR" -type f \( -name "*.csv" -o -name "*.json" \) -exec mv {} "$DEST_DIR" \;

# Check progress
if [ "$(ls -A "$DEST_DIR")" ]; then
    echo "Files successfully moved to $DEST_DIR"
else
    echo "No CSV or JSON files found in $SOURCE_DIR"
fi