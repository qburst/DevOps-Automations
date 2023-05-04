import boto3
from datetime import datetime, timedelta
import time
import pytz
import datetime

monitor_period = 3600 # in seconds
check_interval = 60 # in seconds
utc = pytz.UTC

# Set up a connection to S3 and SNS
s3 = boto3.client('s3')
sns = boto3.client('sns', region_name='')

# Set up SNS topic
topic_arn = ''

# List all the buckets at the start of the script
response = s3.list_buckets()
bucket_names = [bucket['Name'] for bucket in response['Buckets']]

# List to store the buckets that have not received any new objects in the past monitor_period seconds
buckets_without_new_objects = []

while True:
    # Check for new buckets
    response = s3.list_buckets()
    new_buckets = [bucket['Name'] for bucket in response['Buckets'] if bucket['Name'] not in bucket_names]

    if new_buckets:
        bucket_names.extend(new_buckets)

    for bucket_name in bucket_names:
        # Check the bucket for new objects
        try:
            response = s3.list_object_versions(Bucket=bucket_name)
        except Exception as e:
            continue

        # Check if any new objects have been added since the last check
        try:
            new_versions = [version for version in response['Versions'] if version['LastModified'] > utc.localize(datetime.datetime.utcnow()) - timedelta(seconds=monitor_period)]
        except KeyError:
            continue

        if not new_versions and bucket_name not in buckets_without_new_objects:
            # If no new objects have been added and the bucket is not already in the list, add it to the list
            buckets_without_new_objects.append(bucket_name)

    # Check if there are any buckets without new objects
    if buckets_without_new_objects:
        message = f"No objects have been received in the past {monitor_period} seconds for the following buckets:\n{', '.join(buckets_without_new_objects)}"
        # Send an email alert using SNS
        sns.publish(TopicArn=topic_arn, Message=message, Subject="S3 Object Monitoring Alert")
        # Clear the list of buckets without new objects
        buckets_without_new_objects = []
    
    # Wait for the next check
    time.sleep(check_interval)

