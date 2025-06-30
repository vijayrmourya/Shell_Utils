#!/bin/bash

# Resolve directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the function file relative to this script's location
source "$SCRIPT_DIR/../commons/run_command.sh"

OUTPUT_FILE="$SCRIPT_DIR/output.txt"

echo "#####################################" > "$OUTPUT_FILE"
echo "GENERAL INFORMATION ABOUT THE SERVER" >> "$OUTPUT_FILE"
echo "#####################################" >> "$OUTPUT_FILE"

commands=(
    "echo To install any of the required missing softwares on the system:|sudo apt install lsb-release procps util-linux -y"
    "echo To see which Linux distro and version you’re using:|lsb_release -a"
    "echo Information available in the system file os-release:|cat /etc/os-release"
    "echo Will print the system information and it can show some interesting things like kernel version, hardware platform, etc.:|uname -a"
    "echo To see how long the system has been running|uptime"
    "echo Print the user name you logged on with|whoami"
    "echo Show who is logged on|who"
    "echo Who is logged in & what they are doing|w"
)

for pair in "${commands[@]}"; do
    IFS="|" read -r cmd1 cmd2 <<< "$pair"
    run_command "$OUTPUT_FILE" "$cmd1" "$cmd2"
done
