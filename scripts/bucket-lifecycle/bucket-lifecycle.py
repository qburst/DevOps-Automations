import boto3
from botocore.exceptions import ProfileNotFound

profile_name = 'temp'

session = boto3.session.Session(profile_name=profile_name)
s3_client = session.client('s3')

def profile_check():
    try:
        iam_client = session.client('iam')
        response = iam_client.get_user()
    except ProfileNotFound:
        print(f"AWS profile '{profile_name}' does not exist")
profile_check()

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
        except s3_client.exceptions.NoSuchLifecycleConfiguration:
            print("No Lifecycle Configuration Set")
bucket_lifecycle()
