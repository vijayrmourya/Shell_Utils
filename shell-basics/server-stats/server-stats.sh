#!/bin/bash

echo "#################################################"
echo "Server Statistics Viewer"
echo "#################################################"
echo ""

echo "CPU Uage report"
top -bn1 | awk '/Cpu\(s\)/ { usage=100 -$8; printf("CPU Usage: %.1f%%\n", usage) }'
top -bn1 | grep "top"
top -bn1 | grep "Tasks"
top -bn1 | grep "Cpu(s)"
echo "=================================================="

echo "Memory/RAM usage report"
free -h | awk 'NR==2{
    used=$3; total=$2;
    printf "Memory Usage: %2f%% (%dGB / %dGB)\n", used/total*100, used, total
}'
echo "=================================================="

echo "Disk/Storage usage report"
df -h / | awk 'NR==2{
    used=$3; total=$2; pct=$5
    printf "Disk Usage: %s / %s (%s)\n", used, total, pct
}'
echo "=================================================="

echo "Top 5 CPU consuming processes"
ps -eo pid,user,pcpu,pmem,cmd --sort=-pcpu | head -n 6
echo "=================================================="
echo "Top 5 Memory/RAM consuming processes"
ps -eo pid,user,pcpu,pmem,cmd --sort=-pmem | head -n 6

echo ""
echo "#################################################"
echo "Server Statistics Report ends"
echo "#################################################"