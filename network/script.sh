#!/bin/bash

# Resolve directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the function file relative to this script's location
source "$SCRIPT_DIR/../commons/run_command.sh"

OUTPUT_FILE="$SCRIPT_DIR/output.txt"

echo "#####################################" > "$OUTPUT_FILE"
echo "MEASURE NETWORK USAGE" >> "$OUTPUT_FILE"
echo "#####################################" >> "$OUTPUT_FILE"

commands=(
    "echo To install any of the required missing softwares on the system:|sudo apt install net-tools iproute2 ifstat iftop -y"
    "echo Network interfaces and their IP addresses:|ifconfig"
    "echo  modern substitute, but it won’t show you bandwidth usage:|ip address"
    "echo To see bandwidth usage:|netstat -i"
    "echo To see bandwidth usage:|timeout 3 ifstat"
)

for pair in "${commands[@]}"; do
    IFS="|" read -r cmd1 cmd2 <<< "$pair"
    run_command "$OUTPUT_FILE" "$cmd1" "$cmd2"
done
