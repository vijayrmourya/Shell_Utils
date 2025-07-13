#!/bin/bash

system_logger(){
    timestamp="[$(date)]:[$1]::"
    case "$1" in
        [iI][nN][fF][oO]) printf "${timestamp}${2}\n";;
        *)
    esac
}

seperator_line(){
    echo "---------------------------------------------------------------------"
}

CURRENTDATE=$(date)
echo "Basic Syatem Info Report [${CURRENTDATE}]"
echo ============================================
system_logger "INFO" "Current Date & Time: ${CURRENTDATE}"
seperator_line
CURRENTUSER=$(whoami)
system_logger "INFO" "Current User: ${CURRENTUSER}"
seperator_line
UPTIME=$(uptime -p)
system_logger "INFO" "Current session uptime: ${UPTIME}"
seperator_line
OSDETAILS=$(lsb_release -a)
system_logger "INFO" "OS Details:\n${OSDETAILS}"
seperator_line
system_logger "INFO" "Host Details:\n$(hostnamectl)"
seperator_line
KERNEL_NAME=$(uname)
KERNEL_VERSION=$(uname -r)
PROCESSORTYPE=$(uname -p)
HWTYPE=$(uname -i)
system_logger "INFO" "Kernel Information:\nKernel Name:${KERNEL_NAME}\nKernel version:${KERNEL_VERSION}\nProcessor Type:${PROCESSORTYPE}\nHardware Platform:${HWTYPE}"
seperator_line
echo "CPU Uage report"
top -bn1 | awk '/Cpu\(s\)/ { usage=100 -$8; printf("CPU Usage: %.1f%%\n", usage) }'
top -bn1 | grep "top"
top -bn1 | grep "Tasks"
top -bn1 | grep "Cpu(s)"
seperator_line
echo "Memory/RAM usage report"
free -h | awk 'NR==2{
    used=$3; total=$2;
    printf "Memory Usage: %2f%% (%dGB / %dGB)\n", used/total*100, used, total
}'
seperator_line
echo "Disk/Storage usage report"
df -h / | awk 'NR==2{
    used=$3; total=$2; pct=$5
    printf "Disk Usage: %s / %s (%s)\n", used, total, pct
}'
seperator_line
echo "Top 5 CPU consuming processes"
ps -eo pid,user,pcpu,pmem,cmd --sort=-pcpu | head -n 6
seperator_line
echo "Top 5 Memory/RAM consuming processes"
ps -eo pid,user,pcpu,pmem,cmd --sort=-pmem | head -n 6

echo "Basic Syatem Info Report ends here! [${CURRENTDATE}]"
echo ============================================