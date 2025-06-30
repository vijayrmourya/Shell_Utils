#!/bin/bash

# Resolve directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the function file relative to this script's location
source "$SCRIPT_DIR/../commons/run_command.sh"

OUTPUT_FILE="$SCRIPT_DIR/output.txt"

echo "#####################################" > "$OUTPUT_FILE"
echo "MEASURE MEMORY AND CPU USAGE" >> "$OUTPUT_FILE"
echo "#####################################" >> "$OUTPUT_FILE"

commands=(
    "echo To install any of the required missing softwares on the system:|sudo apt install procps -y"
    "echo To check the amount of memory used in the system|free -h"
    "echo Also give some memory statistics|vmstat"
    "echo Is like a Task Manager for Linux, it will display the processes and the consumption of resources|timeout 3 top"
    "echo Interactive and Prettier version|timeout 3 htop"
)

for pair in "${commands[@]}"; do
    IFS="|" read -r cmd1 cmd2 <<< "$pair"
    run_command "$OUTPUT_FILE" "$cmd1" "$cmd2"
done
