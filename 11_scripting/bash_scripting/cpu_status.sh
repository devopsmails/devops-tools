#!/bin/bash

# Get CPU utilization using top command, parse it, and store in a variable
cpu_utilization=$(top -b -n 1 | awk '/%Cpu/ {print 100 - $8}' | awk -F. '{print $1}')

# Check if CPU utilization is greater than 2%
if [ $cpu_utilization -gt 2 ]; then
    echo "Danger! CPU utilization is $cpu_utilization%"
else
    echo "Normal. CPU utilization is $cpu_utilization%"
fi

output:
-----
Danger! CPU utilization is 6%
