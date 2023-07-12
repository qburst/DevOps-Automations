# AWS EC2-instance snapshot using python

A python script which can be executed as a cronjob to take snapshots of the ec2 instances id's listed out in a CSV file and maintain only the given number of snapshots. 

## Global Variables

Name | Description
--- | ---
profile_name | profile name give to validate the AWS credentials
Numberofsnap | no of latest snapshot that needs to be maintained
region | AWS region where the ec2 client will be created
filepath | Path of the CSV file where the instance id's are listed



## Usage

We can run this script as cronjob but by adding the following to the crontab file using `crontab -e` command 

`* * * * * /usr/bin/python3 /pathto/script > /tmp/log_test.txt 2>&1`
