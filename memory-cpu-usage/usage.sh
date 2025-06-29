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
    "free -h"
    "vmstat"
    "top"
)

for cmd in "${commands[@]}"; do
    run_command "\$ $cmd" "$cmd"
done