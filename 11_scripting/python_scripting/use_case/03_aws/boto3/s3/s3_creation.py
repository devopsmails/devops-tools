import boto3

client = boto3.client('s3')

response = client.create_bucket(
    Bucket='gabby-dev-suresh-2',
    CreateBucketConfiguration={
        'LocationConstraint': 'ap-south-1'#Location is must
    }
)
