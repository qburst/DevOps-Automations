#!/usr/local/bin/python
import boto3
import datetime
regions= ['ap-southeast-1', 'us-east-1']
ec2client = boto3.client('ec2')
for region in regions:
    response = ec2client.describe_instances()
    cw = boto3.client('cloudwatch', region_name=region)
    for reservation in response["Reservations"]:
     for instance in reservation["Instances"]:
       ec2 = boto3.resource('ec2')
       eachinstance = instance["InstanceId"]
       cpu = cw.get_metric_statistics(
           Period=604800,
           StartTime=datetime.datetime.utcnow() - datetime.timedelta(seconds=604800),
           EndTime=datetime.datetime.utcnow(),
           MetricName='CPUUtilization',
           Namespace='AWS/EC2',
           Statistics=['Maximum'],
           Dimensions=[{'Name':'InstanceId', 'Value':eachinstance}]
           )
       for value in cpu['Datapoints']:
         if 'Maximum' in value:
            if value['Maximum'] < 10:

               traffic = cw.get_metric_statistics(
               Period=604800,
               StartTime=datetime.datetime.utcnow() - datetime.timedelta(seconds=604800),
               EndTime=datetime.datetime.utcnow(),
               MetricName='NetworkIn',
               Namespace='AWS/EC2',
               Statistics=['Maximum'],
               Dimensions=[{'Name':'InstanceId', 'Value':eachinstance}]
           )      
               for network in traffic['Datapoints']:
                if 'Maximum' in network:
                 if network['Maximum'] < 1000:                  
                  print("Instance Id:", eachinstance,end=" ")
                  print("CPU:",value['Maximum'], "Traffic:",network['Maximum'])

