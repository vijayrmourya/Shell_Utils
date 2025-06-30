#!/bin/bash

echo "===== Sourcing all shell scripts in subdirectories ====="
sudo apt update
find . -type f -name "*.sh" ! -name "main.sh" | while read -r script; do
    echo "Sourcing: $script"
    chmod +x "$script"
    source "$script"
done
