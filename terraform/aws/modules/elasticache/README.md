# ElastiCache Module
This module will creates a fully functional Memcached/Redis cluster via Terraform. As a part of the module it will generate the following:

- A Memcached/Redis cluster.
- A parameter group.
- A subnet group, based on the subnet ids provided.
- A Security group, based on the VPC CIDR provided.
- Two Security group rules,an egress and an ingress rule.

## Inputs
**Important**
All inputs :heavy_check_mark: must be configured.
Any with :x: can be ignored, but can be configurd if we want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| name | All named components will have this variable added as a suffix | :heavy_check_mark: | string | "common" |
| environment | Environment name | :x: | string | "dev" |
| vpc_id | The VPC id in which the cache need to be created | :heavy_check_mark: | string | |
| allowed_cidr| The CIDR blocks allowed in Security group | :heavy_check_mark: | list(string) | |
| subnet_ids | A list of VPC subnet IDs to create the subnet group | :heavy_check_mark: | list(string) | |
| engine | Elastic cache engine | :heavy_check_mark: | string | "memcached" |
| engine_version | Memcached engine version. For more info, see https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/supported-engine-versions.html" | :heavy_check_mark: | string | "1.6.17" |
| instance_type | Elastic cache instance type | :heavy_check_mark: | string | "cache.t2.micro" |
| cluster_size | Cluster size | :heavy_check_mark: | number | 1 |
| parameter_group_name | Name of the existing parameter group | :heavy_check_mark: | string | |
| parameter_group_family | Name of the cache parameter group family | :heavy_check_mark: | string | "memcached1.6" |
| maintenance_window | Maintenance window | :x: | string | |
| apply_immediately | Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | :x: | bool | false |
| notification_topic_arn | An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:xxxxxxxxxx:my_sns_topic | :x: | string | |
| port | Memcached/Redis port | :x: | number | 11211 |
| az_mode | Enable or disable multiple AZs, eg: single-az or cross-az (for memcached only) | :x: | string | "single-az" |
| availability_zone | The Availability Zone of the cluster. az_mode must be set to single-az when used. | :x: | string | |
| availability_zones | List of Availability Zones for the cluster. az_mode must be set to cross-az when used | :x: | list(string) | |
| replication_group_enabled | replication group status for redis | :heavy_check_mark: | string | "disabled" |
| redis_failover | Memcached/Redis port | :x: | number | 11211 |
| auto_minor_version_upgrade | Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window | :x: | bool | true |
| at_rest_encryption_enabled | Whether to enable encryption at rest | :x: | bool | false |
| kms_key_id | The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true | :x: | string | |
| transit_encryption_enabled | Whether to enable encryption in transit. Requires 3.2.6 or >=4.0 redis_version | :x: | bool | false |
| auth_token | The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true. If specified must contain from 16 to 128 alphanumeric characters or symbols | :x: | string | |
| redis_version | Redis version to use, defaults to 3.2.10 | :x: | string | "3.2.10" |
| security_group_names | A list of cache security group names to associate with this replication group | :x: | list(string) | |
| multi_az_enabled | Specifies whether to enable Multi-AZ Support for the replication group | :x: | bool | false |
| snapshot_arns | A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb | :x: | list(string) | |
| snapshot_name | The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource | :x: | string | |
| redis_snapshot_window | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period | :x: | string | "06:30-07:30" |
| redis_snapshot_retention_limit | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes | :x: | number | 0 |
| num_node_groups | Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications. | :x: | number | 0 |
| replicas_per_node_group | Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5. | :x: | number | 0 |


## Note
1. We assume that the VPC and subnets are created already.
2. The aws_elasticache_cluster resource named "memcached" creates a memcached cluster.
3. The aws_elasticache_cluster resource named "redis_node" creates a redis cluster with single node.
4. In this module, aws_elasticache_replication_group resource creates the redis cluster in Cluster Mode "Disabled" as default. This use the following argument:

```
num_cache_clusters            = 1
```

To create the Redis cluster in Cluster Mode "Enabled", following argument is used instead of "num_cache_clusters":
```
num_node_groups               = 2
replicas_per_node_group       = 1
```
5. The type of cache to be created depends upon the values of "replication_group_enabled" and "engine" variables.
 

