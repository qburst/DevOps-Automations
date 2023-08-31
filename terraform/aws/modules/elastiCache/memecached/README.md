# ElastiCache Memcached Module
This module will creates a fully functional Memcached cluster via Terraform. As a part of the module it will generate the following:

- A Memcached cluster.
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
| port | Memcached port | :x: | number | 11211 |
| az_mode | Enable or disable multiple AZs, eg: single-az or cross-az | :x: | string | "single-az" |
| availability_zone | The Availability Zone of the cluster. az_mode must be set to single-az when used. | :x: | string | |
| availability_zones | List of Availability Zones for the cluster. az_mode must be set to cross-az when used | :x: | list(string) | |

## Caveats
1. This module can also be used to make a **single-node Redis instance**, the following argument values will differ. Example:
```
resource "aws_elasticache_cluster" "redis_node" {
  cluster_id           = "dev-redis-node"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
}
```
2. We need to change the parameter_group_family variable accordingly while creating the parameter group for single-redis node.
3. We assume that the VPC and subnets are created already.
