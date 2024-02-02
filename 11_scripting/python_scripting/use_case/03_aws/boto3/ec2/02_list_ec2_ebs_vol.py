import boto3

# Create an EC2 client
region_name = "eu-north-1"
ec2 = boto3.client('ec2', region_name=region_name)

# # Get information about all instances
# response = ec2.describe_instances()
# print(response)
# # Print instance details in a formatted table with info 
# #"Instance ID", "Instance Type", "Instance State", "Tag Value", "Start Date"
# print("{:<20} {:<20} {:<20} {:<20} {:<20}".format("Instance ID", "Instance Type", "Instance State", "Tag Value", "Start Date"))
# print("-"*100)

# for reservation in response['Reservations']:
#     for instance in reservation['Instances']:
#         instance_id = instance['InstanceId']
#         instance_type = instance['InstanceType']
#         instance_state = instance['State']['Name']
#         instance_tag = instance['Tags'][0]['Value']
#         instance_start_dt = instance['LaunchTime']

#         start_date = instance_start_dt.date()
#         print("{:<20} {:<20} {:<20} {:<20} {:<20}".format(instance_id, instance_type, instance_state, 
#                                                           instance_tag, start_date.strftime("%Y-%m-%d")))#Date must be converted to mentioned time
# print("-"*100 + "\n")

#-----------------------------#
#listing volumes
# response = ec2.describe_volumes()
# print(response)

# volumes = response['Volumes']
# print("{:<25} {:<25} {:<25} {:<25} {:<25}".format("vol_id", "vol_status", "vol_type", "vol_attachment", "vol_instance_id"))
# print("-"*125)

# for volume in volumes:
#     vol_id = volume['VolumeId']
#     vol_status = volume['State']
#     vol_type = volume['VolumeType']
#     # vol_attachments = volume['Attachments']
#     try:
#         vol_instance_id = volume['Attachments'][0]['InstanceId']
#         vol_attachment_state = volume['Attachments'][0]['State']
#     except IndexError:
#         vol_instance_id = "None"
#         vol_attachment_state = "None"

#     print("{:<25} {:<25} {:<25} {:<25} {:<25}".format(vol_id, vol_status, vol_type, vol_attachment_state, vol_instance_id))

    
#----------------------------#



