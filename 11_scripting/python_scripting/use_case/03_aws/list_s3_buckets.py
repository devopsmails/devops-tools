'''
Update the package manager:
sudo apt update

Install Python 3 and pip:
sudo apt install python3 python3-pip

python3 --version
pip3 --version
'''

import boto3

# Create an S3 client to connect to the S3 service
s3_client = boto3.client('s3')

# Get a list of all S3 buckets
response = s3_client.list_buckets()
buckets = response['Buckets']

# Print the name of each bucket
for bucket in buckets:
    print(bucket['Name'])
