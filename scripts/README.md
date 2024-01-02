# Scripts

## 1. Find underutilized EC2 machines
[Under Utilized EC2](/scripts/cpu_traffic_multi_region_under-utilized.py)

This Python script can be used to get a report of the under utilized EC2 instances in Multiple regions. You may replace the mentioned region names with the actual ones seprated by commas. The script uses the CPU threshold as 10 and Traffic (NetworkIn) as 1000 and the period taken is 604800 seconds (1 week). Hence this script will take the report of all such under utilized EC2 instances. 

## 2. WordPress Plugin Updater
[WordPress Plugin Updater](/scripts/WordPress_plugin_updater.py)

This Python script is designed to update all instances of a plugin installed on the same machine. It prompts the user to enter the name of the plugin they wish to update and checks if the plugin is already installed on the machine. If it is, the script updates all instances of the plugin on the machine to the specified version. This script requires WP-CLI to be present in the machine.

## 3. Failed Pod identification script:
[Failed Pod identification](/scripts/pod_restart_fail.sh)

This bash script is designed to check the status of pods within a specified namespace. It provides information on pods that are in a failed or restart phase, including their name and status, along with the restart count. he script initializes a variable called 'count' to zero, which is incremented whenever a pod is found in a failed or restart phase. At the end of the iteration, if the 'count' variable remains zero, it indicates that there are no pods in the namespace with failed/restart status.

## 4. Route53 A Record Creation Script
[Route53 A Record Creation Script](/scripts/route53-a-records/a-record.py)

The Route53 A Record Creation Script is a Python script that allows users to create A Records in Amazon Route53. Users can provide a list of IP addresses and a group name, and the script will validate the inputs and perform the necessary checks before creating the records.

## 5. S3 object monitoring script
[S3 object monitoring script](/scripts/s3object_check/s3object_check.py)

This Python script can be used to monitor Amazon S3 buckets for new object versions and send an alert if no new objects have been added to a bucket for a specified period of time.

## 6. EC2 Snapshot Management Script
[EC2 Snapshot Management Script](/scripts/ec2-dailysnapshots/ec2snapshot.py)

The EC2 Snapshot Management Script is a Python script which automates the process of taking snapshots of EC2 instances based on the instance IDs listed in a CSV file. The script also ensures that only a specified number of snapshots are maintained for each instance.

## 7. EC2 Start/Stop Script
[ EC2 Start/Stop Script](/scripts/ec2-stop-start/ec2_stop_start.py)

The EC2 Start/Stop Script is a Python script which can be used to automate the process of stopping and starting Amazon EC2 instances based on predefined schedules by tags.

## 8. EC2 Volume and Snapshot Reporting Script
[EC2 Volume and Snapshot Reporting Script](/scripts/unused_vol_and_orphan_snap_report/aws_utility_script.py)

The EC2 Volume and Snapshot Reporting Script is a Python script that generates a report in CSV format, identifying unused volumes and orphan snapshots in your AWS EC2 environment. This script helps you identify and manage resources that are no longer associated with running instances, ensuring efficient resource allocation.

## 9. AWS Opensearch Snapshot automation
[Snapshot script](/scripts/aws-opensearch-snapshot-automation/snapshot.py)

The Opensearch snapshot script is a python script which can be used to automate the process of taking snapshots into a custom repository.

## 10. Get logs from S3 based on time stamp
[Download logs from S3 based on timestamp](scripts/download_logs_from_s3.sh)

This script is a bash script to quickly get all logs between 2 timestamps from S3. In the many cases where you need to download logs for debugging, it will help quickly get the logs to your local.

## 11. Get logs from RDS based on time stamp
[Download logs from RDS based on timestamp](scripts/download_logs_from_rds.sh)

This script is a bash script to quickly get all logs between 2 timestamps for a particular RDS. In the many cases where you need to download logs for debugging, it will help quickly get the logs to your local.

## 12. Domain Expiry Check Script
[Domain Expiry Check Script](/scripts/domain-expiry-check/domain_expiry_checker.sh)

A bash script to monitor the expiration dates of domain names. It fetches domain information using WHOIS queries and send email alerts when domains are about to expire.
