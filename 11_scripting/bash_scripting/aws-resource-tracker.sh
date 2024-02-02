#!/bin/bash

#################
#Author: Suresh
#Date:31/08/2023

#Version: v1
#Summary: This shell script reports the  usage of AWS RESOURCES list
################

set -x

aws s3 ls
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

aws iam list-users

aws lambda list-functions
