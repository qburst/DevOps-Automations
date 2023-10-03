#!/usr/bin/python

## Volume state =================================================================
# creating - The volume is being created.
# available - The volume is not attached to an instance.
# in-use - The volume is attached to an instance.
# deleting - The volume is being deleted.
# deleted - The volume is deleted.
# error - The underlying hardware related to your EBS volume has failed, 
#         and the data associated with the volume is unrecoverable
#================================================================================

import os, sys, re
import boto3
import argparse
import datetime
import csv
import shlex
import subprocess
from botocore.exceptions import ClientError

# check aws cli installation
def check_aws_cli():
    proc = subprocess.call(['bash', '-c', 'which aws > /dev/null'])
    if not proc == 0:
        print("AWS CLI not installed, install and configure")
        sys.exit(1)

# List all regions
def list_all_regions():
    client = boto3.client('ec2')
    regions = [region['RegionName'] for region in client.describe_regions()['Regions']]
    return regions

# Get instance_id, image_id from description
def parse_description(description):
    regex = r"^Created by CreateImage\((.*?)\) for (.*?) "
    matches = re.finditer(regex, description, re.MULTILINE)
    for matchNum, match in enumerate(matches):
        return match.groups()
    return '', ''

# Check if vol with the vol_id exists
def volume_exists(volume_id, ec2):
    if not volume_id:
        return False
    try:
        ec2.describe_volumes(VolumeIds=[volume_id])
        return True
    except ClientError:
        return False

# Check if instance with instance_id exists
def instance_exists(instance_id, ec2):
    if not instance_id:
        return ''
    try:
        return len(ec2.describe_instances(InstanceIds=[instance_id])['Reservations']) != 0
    except ClientError:
        return False

# Check if image with image_id exists
def image_exists(image_id, ec2):
    if not image_id:
        return ''
    try:
        return len(ec2.describe_images(ImageIds=[image_id])['Images']) != 0
    except ClientError:
        return False
        
# Get all snapshots.
def get_snapshots(region):
    ec2 = boto3.client('ec2', region_name=region)
    for snapshot in ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']:
        instance_id, image_id = parse_description(snapshot['Description'])
        yield {
            'id': snapshot['SnapshotId'],
            'description': snapshot['Description'],
            'start_time': snapshot['StartTime'],
            'size': snapshot['VolumeSize'],
            'volume_id': snapshot['VolumeId'],
            'volume_exists': volume_exists(snapshot['VolumeId'],ec2),
            'instance_id': instance_id,
            'instance_exists': instance_exists(instance_id, ec2),
            'ami_id': image_id,
            'ami_exists': image_exists(image_id, ec2),
        }

# write orphan snapshot to csv file
def write_orphan_snapshot_to_csv(snap_id, region, action):
    data = [snap_id, region, action]
    with open('orphan_snapshots.csv', 'a', encoding='UTF8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(data)

# Get orphan snapshot
def get_orphan_snapshot_and_gen_report():
    listOfRegions = list_all_regions()
    write_orphan_snapshot_to_csv("SNAPSHOT_IDS","REGION","ACTION")
    for count, region in enumerate(listOfRegions):
        print("checking orphan snapshot for",region)
        for snapshot in get_snapshots(region):
            if not snapshot['volume_exists'] and not snapshot['ami_exists'] and not snapshot['instance_exists']:
                write_orphan_snapshot_to_csv(snapshot['id'], region, "DEL")

# get the unused volume for all region
def get_unused_vol(region):
    client = boto3.client('ec2', region_name=region)
    for _, vol in enumerate(client.describe_volumes()['Volumes']):
        attachments = vol['Attachments']
        state = vol['State']
        if not attachments and state == "available":
            row = [vol['VolumeId'],vol['State'], region, "DEL", "volume is not attached to an instance"]
            del_volume(client, vol['VolumeId'])
            return row
        elif state == "error":
            row = [vol['VolumeId'],vol['State'], region, "DEL", "EBS volume has failed"]
            del_volume(client, vol['VolumeId'])
            return row

# write unused volume to csv and generate report
def write_unused_vol_to_csv(data):
    header = ["VOLUME_ID","STATUS","REGION","ACTION","DESC"]
    with open('unused_vol.csv', 'a', encoding='UTF8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(data)
    if data:
        print("Unused Volume")
        print(data)

#TODO
def del_volume(client, volume_to_delete):
    # print("Deleting voulume id:", volume_to_delete)
    # client.delete_volume(VolumeId = volume_to_delete)
    pass

# create backup of old report
def renamed_old_report():
    orphan_snapshots_file = "orphan_snapshots.csv"
    unused_vol_file = "unused_vol.csv"
    output_dir = str(datetime.datetime.now()).replace(':', '-').replace(' ', '-').replace('.', '-')
    if os.path.isfile(orphan_snapshots_file):
        os.rename(orphan_snapshots_file, "orphan_snapshots_"+output_dir+".csv")
    elif os.path.isfile(unused_vol_file):
        os.rename(unused_vol_file, "unused_vol_"+output_dir+".csv")
    else:
        pass

def verify_args(args):
    if args.action == None:
        print("usage: aws_utility_script.py -a report_unused_vol or aws_utility_script.py -a report_orphan_snapshot")
        sys.exit(2)
    return args

# get unused volume and geneate report
def get_unused_vol_and_gen_report():
    listOfRegions = list_all_regions()
    data = []
    for region in listOfRegions:
        row = get_unused_vol(region)
        if not row is None:
            data.append(row)
    write_unused_vol_to_csv(data)

def main():
    parser = argparse.ArgumentParser(description="Script to report unused volumes and orphan snapshots to CSV file.")
    parser.add_argument("-a","--action", dest="action", type=str, help="Action can be either of the two values report_unused_vol / report_orphan_snapshot")
    
    args = parser.parse_args()
    verify_args(args)
    action = args.action

    check_aws_cli()
    renamed_old_report()

    if action.lower() == "report_unused_vol":
        get_unused_vol_and_gen_report()
    elif action.lower() == "report_orphan_snapshot":
        get_orphan_snapshot_and_gen_report()
    else:
        print("usage: aws_utility_script.py -a report_unused_vol or aws_utility_script.py -a report_orphan_snapshot")

if __name__ == '__main__':
    main()