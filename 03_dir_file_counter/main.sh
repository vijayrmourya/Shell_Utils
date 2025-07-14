#!/bin/bash

# Set the base directory to $1 or current directory if not provided
BASE_DIR="${1:-.}"

# Recursively find directories, skipping ones starting with .
find "$BASE_DIR" -type d \( -name '.*' -prune \) -o -type d -print | while read -r dir; do
    count=$(find "$dir" -maxdepth 1 -type f | wc -l)
    if [ "$count" -gt 0 ]; then
        printf "%d file(s) in : %-30s\n" "$count" "$dir"
    fi
done
