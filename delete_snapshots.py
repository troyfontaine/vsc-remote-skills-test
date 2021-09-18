#!/usr/bin/env python3

import boto3

# Get the account ID for the calling user
owner = boto3.client('sts').get_caller_identity()['Account']

# Connected to AWS
client = boto3.client('ec2', region_name='us-west-2')

# Get a list of AMIs
amis = client.describe_images(Owners=['self'])

# Get a list of snapshots
snapshots = client.describe_snapshots(OwnerIds=["{}".format(owner)])

# Loop over AMIs and deregister them
for ami in amis['Images']:
    print("Attempting to deregister AMI with ID {}".format(ami['ImageId']))
    try:
        ami_id = ami['ImageId']
        client.deregister_image(ImageId=ami_id)
    except Exception as e:
        print('Error encountered {}'.format(e))
        continue

# Loop over snapshots and delete them
for snapshot in snapshots['Snapshots']:
    print("Attempting to delete snapshot with ID {}".format(snapshot['SnapshotId']))
    try:
        id = snapshot['SnapshotId']
        client.delete_snapshot(SnapshotId=id)
    except Exception as e:
        if 'InvalidSnapshot.InUse' in e.response['Error']['Code']:
            print("skipping this snapshot")
            continue
