#!/bin/bash

echo "#####################################"
echo "HARDWARE INFORMATION"
echo "#####################################"

run_command(){
    echo "========================="
    echo $1
    echo "========================="
    $2
}

commands=(
    "sudo lshw"
    "sudo lscpu"
    "sudo lsblk"
    "sudo lspci"
    "sudo lsusb"
)

for cmd in "${commands[@]}"; do
    run_command "\$ $cmd" "$cmd"
done