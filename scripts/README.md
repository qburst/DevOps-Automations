## Find underutilized EC2 machines
[Under Utilized EC2](scripts/cpu_traffic_multi_region_under-utilized.py)

This Python script can be used to get a report of the under utilized EC2 instances in Multiple regions. You may replace the mentioned region names with the actual ones seprated by commas.
The script uses the CPU threshold as 10 and Traffic (NetworkIn) as 1000 and the period taken is 604800 seconds (1 week). Hence this script will take the report of all such under utilized EC2 instances. 

## AWS EC2-instance snapshot using python


A simple Python application illustrating usage of the AWS SDK for Python. The script takes snapshot of all the volumes attached to the ec2-instance and retains the lastest snapshots according to the input given.
