import boto3
access_key = input("Enter your AWS access key: ")
secret_key = input("Enter your AWS secret key: ")
session = boto3.Session(
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key
)
region = input("Enter region name: ")
ec2 = session.client('ec2', region_name=region)
response = ec2.describe_volumes()

volumes = response['Volumes']
volumelist=[]
for volume in volumes:
    volumelist.append(volume['VolumeId'])
if len(volumelist) == 0:
    print("No volumes available in %s region" % region)
else:
    print("The id's of the available ebs volumes in %s region are as follows :" % region,*volumelist, sep = "\n")
    
VolumeIDs = input("Enter the volume ID's for which the snapshots must be taken (separated by space): ").split()
Numberofsnap = input("Enter the number of snapshot that must be retained(corresponding to each volumes mentioned above): ").split()

snapshots = list(zip(VolumeIDs,Numberofsnap))
description = "scripted backup"
for volume, max_snapshots in snapshots:
  response = ec2.create_snapshot(VolumeId=volume, Description=description)
  print("Creating snapshot with snap id %s for the volume %s" %(response['SnapshotId'],volume))
  snaps= ec2.describe_snapshots(Filters=[{'Name': 'volume-id', 'Values': [volume]}])
  old_snapshots = sorted(snaps['Snapshots'], key=lambda x: x['StartTime'], reverse=True)
  for i in range(int(max_snapshots), len(old_snapshots)):
        snapshot_to_delete = old_snapshots[i]['SnapshotId']
        print("Purging older snapshots with id %s" % snapshot_to_delete, sep = "\n")
        deleted_snapshots = ec2.delete_snapshot(SnapshotId=snapshot_to_delete)
