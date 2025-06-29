#!/bin/bash

echo "#####################################"
echo "GENERAL INFORMATION ABOUT THE SERVER"
echo "#####################################"

run_command(){
    echo "========================="
    echo $1
    echo "========================="
    $2
}

commands=(
    "lsb_release -a"
    "cat /etc/os-release"
    "uname -a"
    "uptime"
    "whoami"
    "who"
    "w"
)

for cmd in "${commands[@]}"; do
    run_command "\$ $cmd" "$cmd"
done