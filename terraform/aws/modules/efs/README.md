# EFS Module
This module will create EFS. As a part of the module it will generate the following

- 1 EFS in bursting throughput mode .


## Inputs
**Important**
    All inputs :heavy_check_mark: must be configured.
    Any with :x: can be ignored, but can be configurd if you want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| creation_token | A unique name (a maximum of 64 characters are allowed) used as reference when creating the Elastic File System to ensure idempotent file system creation | :x: | string | If not provided, it will generated by Terraform|
| performance_mode | The file system performance mode | :x:| string | "generalPurpose" |
| throughput_mode |  Throughput mode for the file system | :x: | string | "bursting" |
| encrypted | Disk encryption to be set | :x: | bool |  |
| kms_key_id| ARN of the KMS key to be used for encryption.This is to be set if encrypted is set to true | :x: | string | |
| file_system_id | The ID of the file system for which the mount target is intended | :heavy_check_mark: | string | |
| subnet_id | The ID of the subnet to add the mount target in | :heavy_check_mark: | string | |
| security_groups | A list of up to 5 VPC security group IDs | :x: | string | |
| enable_key_rotation | Variable to set rotation for keys | :x: | bool | false |