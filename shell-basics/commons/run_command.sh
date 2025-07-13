#!/bin/bash

run_command(){
    local output_file=$1
    local cmd1=$2
    local cmd2=$3

    {
        echo "========================="
        eval "$cmd1"
        echo ">> Running: $cmd2"
        echo "========================="
        eval "$cmd2"
    } >> "$output_file" 2>&1
}
