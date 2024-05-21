import os
import sys
import boto3
import configparser
from botocore.exceptions import ClientError

def check_aws_profile(profile_name):
    aws_config_path = os.path.expanduser('~/.aws/config')
    aws_credentials_path = os.path.expanduser('~/.aws/credentials')

    config = configparser.ConfigParser()
    config.read([aws_config_path, aws_credentials_path])

    if profile_name in config.sections():
        pass
    else:
        print(f"AWS profile '{profile_name}' does not exist.")
        sys.exit()

profile_name = 'temp-profile'
check_aws_profile(profile_name)

session = boto3.session.Session(profile_name=profile_name)
s3_client = session.client('s3')

def get_aws_account_id():
    sts = session.client('sts')
    AWS_ACCOUNT_ID = sts.get_caller_identity()["Account"]
    print("AWS Account ID:", AWS_ACCOUNT_ID)
    print()
get_aws_account_id()

def bucket_lifecycle():
    response = s3_client.list_buckets()
    for bucket in response['Buckets']:
        bucket_name = bucket['Name']
        print(f"Bucket Name: {bucket_name}")
        lifecycle_policies = []

        try:
            lifecycle_configuration = s3_client.get_bucket_lifecycle_configuration(Bucket=bucket_name)
            rules = lifecycle_configuration.get('Rules', [])
            if rules:
                print("Lifecycle Policies:")
                for rule in rules:
                    print(f" - {rule}")
                    lifecycle_policies.append(rule)
                    print()
            else:
                print("No Lifecycle Policies")
        except ClientError:
            print("No Lifecycle Configuration Set")
            print()
bucket_lifecycle()
