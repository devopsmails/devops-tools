#!/bin/bash
#################
#author:
#Date:

#Summary of the script:

#Version: v1
################

set -x #debug mode 
set -e #Exit when error 
set -o #stops when even pipefails (usally when pipe is mentioned only last command in pipe is success it assumes as success). 

df -h
free -g
nproc

i
