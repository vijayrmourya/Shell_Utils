#!/bin/bash

# Resolve directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the function file relative to this script's location
source "$SCRIPT_DIR/../commons/run_command.sh"

OUTPUT_FILE="$SCRIPT_DIR/output.txt"

echo "#####################################" > "$OUTPUT_FILE"
echo "HARDWARE INFORMATION" >> "$OUTPUT_FILE"
echo "#####################################" >> "$OUTPUT_FILE"

commands=(
    "echo To install any of the required missing softwares on the system:|sudo apt install lshw util-linux pciutils usbutils -y"
    "echo Get detailed information on the hardware configuration, and there’s a bunch of switches we can use to filter the information we want to see|sudo lshw"
    "echo To display information about the CPU architecture|sudo lscpu"
    "echo To list block devices|sudo lsblk"
    "echo To list all PCI(Peripheral Component Interconnect) devices|sudo lspci"
    "echo To list USB devices|sudo lsusb"
)

for pair in "${commands[@]}"; do
    IFS="|" read -r cmd1 cmd2 <<< "$pair"
    run_command "$OUTPUT_FILE" "$cmd1" "$cmd2"
done
