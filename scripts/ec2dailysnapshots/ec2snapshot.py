import boto3
import csv
from botocore.exceptions import ProfileNotFound

#Modify the following variables before running the scripts
profile_name = ''
Numberofsnap = 1
snapshots=[]
region='us-east-1'
file_path= ''

#Setting up connection and verfying the profile name
session = boto3.Session(profile_name=profile_name)
ec2 = session.client('ec2', region_name=region)
try:
    iam_client = session.client('iam')
    response = iam_client.get_user()
except ProfileNotFound:
    print("AWS profile '{profile_name}' does not exist")
 
#Open and read the CSV file containing the Instance Id's
with open(file_path,'r') as file:
    reader = csv.reader(file)
    next(reader) 
    for row in reader:
        instance_id = row[0]
        snapshots.append((instance_id, Numberofsnap))
#Initiating snapshot for each volume available attached to the instance and puring the oldest snapshots        
for instance, max_snapshots in snapshots:
  response = ec2.describe_volumes(Filters=[{'Name': 'attachment.instance-id', 'Values': [instance]}])
  for volume in response['Volumes']:
    volume_id = volume['VolumeId']
    description = 'Snapshot of volume ' + volume_id
    response = ec2.create_snapshot(VolumeId=volume_id, Description=description)
    try:
            snapshot_id = response['SnapshotId']
            snapshot_complete_waiter = ec2.get_waiter('snapshot_completed')
            snapshot_complete_waiter.wait(SnapshotIds=[snapshot_id])

    except botocore.exceptions.WaiterError as e:
                print(e)
    
    snaps= ec2.describe_snapshots(Filters=[{'Name': 'volume-id', 'Values': [volume_id]}])
    old_snapshots = sorted(snaps['Snapshots'], key=lambda x: x['StartTime'], reverse=True)
    for i in range(int(max_snapshots), len(old_snapshots)):
          snapshot_to_delete = old_snapshots[i]['SnapshotId']
          ec2.delete_snapshot(SnapshotId=snapshot_to_delete)
