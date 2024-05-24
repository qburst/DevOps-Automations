# Bucket Lifecycle Script

The bucket lifecycle script is a Python script which can be used to list all S3 buckets in a AWS account and lifecycle of each S3 bucket using boto3 library.

## Prerequisites

- Ensure that you have Python installed on your system.
- Install dependencies using the command:
    `pip3 install -r requirements.txt`
- Replace `profile_name` with the actual profile name in your system.

## Usage

1. Clone this repository.
2. Navigate to project's directory.
3. Replace `profile_name` with the actual profile name in your system.
4. Run the script as `python3 bucket-lifecycle.py`

## Sample Terminal Output

```
$ python3 bucket-lifecycle.py
AWS Account ID: 5084254

Bucket Name: aws-test-assets-us-east-1
No Lifecycle Configuration Set

Bucket Name: test-training
Lifecycle Policies:
 - {'ID': 'Archive Old Files', 'Filter': {'Prefix': 'test_db'}, 'Status': 'Enabled', 'NoncurrentVersionExpiration': {'NoncurrentDays': 3}}

Bucket Name: test-bucket-lifecycle-copy
Lifecycle Policies:
 - {'ID': 'test-rule-1', 'Filter': {'Prefix': 'test-rule-1'}, 'Status': 'Enabled', 'Transitions': [{'Days': 30, 'StorageClass': 'STANDARD_IA'}]}

 - {'ID': 'test-rule-2', 'Filter': {'Prefix': 'test-rule-2'}, 'Status': 'Enabled', 'Transitions': [{'Days': 30, 'StorageClass': 'INTELLIGENT_TIERING'}]}
```
