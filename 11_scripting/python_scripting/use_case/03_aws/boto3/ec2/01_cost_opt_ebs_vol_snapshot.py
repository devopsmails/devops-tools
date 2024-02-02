# # import boto3 
# # region_name = "eu-north-1"
# # ec2_client = boto3.client('ec2', region_name=region_name)
# # ebs_client = boto3.client('ebs', region_name=region_name)
# # snapshot_client = boto3.client('ec2', region_name=region_name)

# # #*****list of ec2 instances with state & launched date
# # response = ec2_client.describe_instances()
# # # print(ec2_ec2_response)
# # instnaces = response['Reservations']
# # for reservation in ec2_response['Reservations']:
# #     instances = reservation['Instances']
# #     for instance in instances:
# #         launch_date = instance['LaunchTime']
# #         print("Instance Name:", instance['Tags'][0]['Value'] 
# #               + ", " + "state:", instance['State']['Name'] 
# #               + ", "+"launched_date:", launch_date.date())

# # #****list ebs volumes & attached to any ec2 or not
        
# # vol_response = client.describe_volumes()

# import boto3
# import datetime
# region_name = "eu-north-1"
# # Create an EC2 client
# ec2_client = boto3.client('ec2', region_name=region_name)

# # Get a list of all volumes and their attachment status
# volumes = ec2_client.describe_volumes()['Volumes']
# attached_volumes = [vol for vol in volumes if vol.get('Attachments')]
# unattached_volumes = [vol for vol in volumes if not vol.get('Attachments')]

# # Get a list of all snapshots
# snapshots = ec2_client.describe_snapshots()['Snapshots']

# # Print EC2 instances
# print("EC2 Instances:")
# for reservation in ec2_client.describe_instances()['Reservations']:
#    for instance in reservation['Instances']:
#        print(f"Instance ID: {instance['InstanceId']}")
#        print(f"Instance Type: {instance['InstanceType']}")
#        print(f"State: {instance['State']['Name']}")
#        print(f"Launch Time: {instance['LaunchTime']}")
#        print("-" * 30)

# # Print attached volumes
# print("\nAttached Volumes:")
# for volume in attached_volumes:
#    print(f"Volume ID: {volume['VolumeId']}")
#    print(f"Size: {volume['Size']} GiB")
#    print(f"State: {volume['State']}")
#    print(f"Attached to: {volume['Attachments'][0]['InstanceId']}")
#    print("-" * 30)

# # Check and handle unattached volumes
# print("\nUnattached Volumes:")
# for volume in unattached_volumes:
#    print(f"Volume ID: {volume['VolumeId']}")
#    print(f"Size: {volume['Size']} GiB")
#    print(f"State: {volume['State']}")
#    print(f"Not attached to an EC2 instance since: {datetime.datetime.now() - volume['CreateTime']}")

#    if (datetime.datetime.now() - volume['CreateTime']) > datetime.timedelta(days=90):
#        delete_choice = input("Delete this volume (y/n)? ")
#        if delete_choice.lower() == 'y':
#            print(f"Deleting volume {volume['VolumeId']}...")
#            ec2_client.delete_volume(VolumeId=volume['VolumeId'])
#        else:
#            print("Leaving volume as it is.")
#    print("-" * 30)

# # Check and handle snapshots
# print("\nSnapshots:")
# for snapshot in snapshots:
#    if not snapshot.get('VolumeId'):
#        print(f"Snapshot ID: {snapshot['SnapshotId']}")
#        print(f"Not attached to a volume.")
#        print(f"StartTime: {snapshot['StartTime']}")

#        if (datetime.datetime.now() - snapshot['StartTime']) > datetime.timedelta(days=90):
#            delete_choice = input("Delete this snapshot (y/n)? ")
#            if delete_choice.lower() == 'y':
#                print(f"Deleting snapshot {snapshot['SnapshotId']}...")
#                ec2_client.delete_snapshot(SnapshotId=snapshot['SnapshotId'])
#            else:
#                print("Leaving snapshot as it is.")
#        print("-" * 30)
