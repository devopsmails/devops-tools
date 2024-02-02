import boto3

client = boto3.client('s3')
response = client.list_buckets()

buckets = response["Buckets"]

for bucket in buckets:
    print(bucket["Name"])

# output

# gabby-dev-suresh-2
# suresh-dev-gabby-1
