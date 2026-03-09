# AWS Aurora PostgreSQL Module

This module creates an Amazon Aurora PostgreSQL cluster with KMS encryption at rest, private network placement, and strictly disabled public accessibility. It supports both provisioned instances and Aurora Serverless. You can supply an existing DB subnet group or let the module create one from a list of subnet IDs. Cluster and DB parameter groups are created by the module and can be customized via variables.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply_immediately](#input_apply_immediately) | If true, applies modifications immediately instead of during the next maintenance window. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto_minor_version_upgrade](#input_auto_minor_version_upgrade) | If true, minor engine upgrades are applied automatically. | `bool` | `true` | no |
| <a name="input_backup_retention_period"></a> [backup_retention_period](#input_backup_retention_period) | Number of days to retain automated backups. Set to 0 to disable. | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup_window](#input_backup_window) | Preferred backup window in UTC (e.g. 03:00-04:00). | `string` | `"03:00-04:00"` | no |
| <a name="input_cluster_parameters"></a> [cluster_parameters](#input_cluster_parameters) | List of cluster parameters. Each object has name, value, and optional apply_method. | `list(object)` | `[]` | no |
| <a name="input_db_name"></a> [db_name](#input_db_name) | Name of the initial database to create. | `string` | n/a | yes |
| <a name="input_db_parameters"></a> [db_parameters](#input_db_parameters) | List of DB instance parameters. Each object has name, value, and optional apply_method. | `list(object)` | `[]` | no |
| <a name="input_db_subnet_group_name"></a> [db_subnet_group_name](#input_db_subnet_group_name) | Name of an existing DB subnet group. If empty, the module creates one using subnet_ids. | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion_protection](#input_deletion_protection) | If true, enables deletion protection for the Aurora cluster. | `bool` | `true` | no |
| <a name="input_engine_mode"></a> [engine_mode](#input_engine_mode) | Engine mode: `provisioned` or `serverless`. | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine_version](#input_engine_version) | Aurora PostgreSQL engine version (e.g. 15.5). | `string` | n/a | yes |
| <a name="input_final_snapshot_identifier"></a> [final_snapshot_identifier](#input_final_snapshot_identifier) | Identifier for the final snapshot when the cluster is destroyed (when skip_final_snapshot is false). | `string` | `""` | no |
| <a name="input_identifier"></a> [identifier](#input_identifier) | Cluster identifier for the Aurora PostgreSQL cluster. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance_class](#input_instance_class) | Instance class when engine_mode is `provisioned` (e.g. db.r6g.large). | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance_count](#input_instance_count) | Number of cluster instances when engine_mode is `provisioned`. | `number` | `2` | no |
| <a name="input_kms_key_id"></a> [kms_key_id](#input_kms_key_id) | ARN or ID of the KMS key for encrypting Aurora storage and snapshots. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window) | Preferred maintenance window in UTC. | `string` | `"sun:04:00-sun:05:00"` | no |
| <a name="input_multi_az"></a> [multi_az](#input_multi_az) | Reserved for compatibility. | `bool` | `false` | no |
| <a name="input_password"></a> [password](#input_password) | Master password for the Aurora PostgreSQL cluster. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input_region) | AWS region (for reference; region is set by the provider). | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip_final_snapshot](#input_skip_final_snapshot) | If true, no final snapshot is created when the cluster is destroyed. | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | Subnet IDs for the DB subnet group when the module creates it (required if db_subnet_group_name is empty). | `list(string)` | `[]` | no |
| <a name="input_serverless_auto_pause"></a> [serverless_auto_pause](#input_serverless_auto_pause) | Whether to auto-pause Aurora Serverless when idle. | `bool` | `false` | no |
| <a name="input_serverless_max_capacity"></a> [serverless_max_capacity](#input_serverless_max_capacity) | Maximum capacity (ACUs) for Aurora Serverless. | `number` | `8` | no |
| <a name="input_serverless_min_capacity"></a> [serverless_min_capacity](#input_serverless_min_capacity) | Minimum capacity (ACUs) for Aurora Serverless. | `number` | `2` | no |
| <a name="input_serverless_seconds_until_auto_pause"></a> [serverless_seconds_until_auto_pause](#input_serverless_seconds_until_auto_pause) | Seconds until Aurora Serverless is auto-paused when auto_pause is true. | `number` | `300` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to the Aurora cluster and its instances. | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input_username) | Master username for the Aurora PostgreSQL cluster. | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc_security_group_ids](#input_vpc_security_group_ids) | List of existing VPC security group IDs to attach to the cluster. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster_arn](#output_cluster_arn) | ARN of the Aurora PostgreSQL cluster. |
| <a name="output_cluster_id"></a> [cluster_id](#output_cluster_id) | ID of the Aurora PostgreSQL cluster. |
| <a name="output_cluster_endpoint"></a> [cluster_endpoint](#output_cluster_endpoint) | Writer endpoint for the Aurora PostgreSQL cluster. |
| <a name="output_cluster_reader_endpoint"></a> [cluster_reader_endpoint](#output_cluster_reader_endpoint) | Reader endpoint for the Aurora PostgreSQL cluster. |
| <a name="output_port"></a> [port](#output_port) | Port the database is listening on. |
| <a name="output_db_subnet_group_name"></a> [db_subnet_group_name](#output_db_subnet_group_name) | Name of the DB subnet group in use. |
| <a name="output_cluster_parameter_group_name"></a> [cluster_parameter_group_name](#output_cluster_parameter_group_name) | Name of the RDS cluster parameter group. |
| <a name="output_db_parameter_group_name"></a> [db_parameter_group_name](#output_db_parameter_group_name) | Name of the DB parameter group. |
