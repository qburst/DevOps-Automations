import os
import boto3

region = os.environ['REGION']
instance_ids = os.environ['INSTANCE_IDS'].split(',')
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instance_ids)
    print('stopped your instances: ' + str(instance_ids))
