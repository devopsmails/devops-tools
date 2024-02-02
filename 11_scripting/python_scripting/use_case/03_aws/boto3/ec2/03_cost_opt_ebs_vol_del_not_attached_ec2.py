import boto3

region_name = "eu-north-1"

ec2 = boto3.client('ec2', region_name=region_name)

# Get all volumes
response = ec2.describe_volumes()
volumes = response['Volumes']


# Iterate through volumes
for volume in volumes:
    vol_id = volume['VolumeId']
    vol_status = volume['State']
    vol_attachments = volume.get('Attachments', [])  # Handle potential absence of attachments

    if not vol_attachments and vol_status == 'available':  # Check for unattached, available volumes
        print(f"Unattached volume found: {vol_id}")
        while True:
            choice = input("Delete this volume? (y/n): ").lower()
            if choice in ('y', 'n'):
                break
            print("Invalid input. Please enter 'y' or 'n'.")

        if choice == 'y':
            try:
                print(f"Deleting volume: {vol_id}")
                ec2.delete_volume(VolumeId=vol_id)
            except Exception as e:
                print(f"Error deleting volume {vol_id}: {e}")
