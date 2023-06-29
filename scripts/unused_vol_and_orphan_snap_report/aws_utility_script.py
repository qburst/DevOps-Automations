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

import os, sys
import boto3
import argparse
import datetime
import csv
import shlex
import subprocess

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

# get the orphan snapshot on all region
def read_snap_from_file(orphan_snap_report_file):
    snapshots_list = []
    with open(orphan_snap_report_file,'r') as f:
        for line in f:
            for word in line.split():
               snapshots_list.append(word)
    return snapshots_list

# write orphan snapshot to csv and generate report
def write_orphan_snapshot_to_csv(orphan_snap_report_file, region, snap_row, count):
    if count == 0:
        header = ["SNAPSHOT_IDS","REGION","ACTION"]
        with open('orphan_snapshots.csv', 'a', encoding='UTF8', newline='') as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(snap_row)
    else:
        with open('orphan_snapshots.csv', 'a', encoding='UTF8', newline='') as f:
            writer = csv.writer(f)
            writer.writerows(snap_row)
            if snap_row:
                print("Orphan Snapshot")
                print(snap_row)

# read orphan snapshot from bash and write to text file
def read_orphan_snapshot(aws_account_id, orphan_snap_report_file, region, count):
    orphaned_snapshot_ids = "echo $(comm -23 <(aws ec2 describe-snapshots --owner-ids "+aws_account_id+" \
        --query  'Snapshots[*].SnapshotId' --output text | tr '\\t' '\\n' | sort) <(aws ec2 \
        describe-images --filters Name=state,Values=available --owners "+aws_account_id+" --query \
        'Images[*].BlockDeviceMappings[*].Ebs.SnapshotId' --output text | tr '\\t' '\\n' | sort | uniq))"
    proc = subprocess.call(['bash', '-c', orphaned_snapshot_ids +' > '+ orphan_snap_report_file])
    if proc == 0:
        if os.stat(orphan_snap_report_file).st_size == 0:
            print("Orphan Snapshot not found")
            sys.exit(0)

        snapshots_list = read_snap_from_file(orphan_snap_report_file)
        snap_row = []
        for snapshots in snapshots_list:
            snap_row.append([snapshots,region,"DEL"])
        write_orphan_snapshot_to_csv(orphan_snap_report_file, region, snap_row, count)

# get the default region set by user
def get_default_region(region_filename):
    default_region = "aws configure get region"
    proc = subprocess.call(['bash', '-c', default_region+' > '+region_filename])

# set the default region use by user
def set_default_region(region_filename):
    f = open(region_filename, "r")
    default_region = f.read().strip()
    set_region(default_region)
    remove_temp_file(region_filename)

# set the regions to get the orphan snapshot
def set_region(region):
    update_region = "aws configure set default.region "+region
    proc = subprocess.call(['bash', '-c', update_region])

# remove intermediate files
def remove_temp_file(report_file):
    proc = subprocess.call(['bash', '-c', 'rm -rf '+report_file])
    if proc == 0:
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

# get orphan snapshot for all regions
def get_orphan_snapshot_and_gen_report(aws_account_id, orphan_snap_report_file, region_filename):
    listOfRegions = list_all_regions()
    if not aws_account_id:
        aws_account_id = "self"
    for count, region in enumerate(listOfRegions):
        set_region(region)
        read_orphan_snapshot(aws_account_id, orphan_snap_report_file, region, count)
    remove_temp_file(orphan_snap_report_file)

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
    aws_account_id = ""
    region_filename = ".region_file"
    orphan_snap_report_file = ".output_file"

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
        default_region = get_default_region(region_filename)
        get_orphan_snapshot_and_gen_report(aws_account_id, orphan_snap_report_file, region_filename)
        set_default_region(region_filename)
    else:
        print("usage: aws_utility_script.py -a report_unused_vol or aws_utility_script.py -a report_orphan_snapshot")

if __name__ == '__main__':
    main()