# AWS DMS Migration Module

This module creates an AWS Database Migration Service (DMS) replication instance and a replication task. You can supply an existing DMS replication subnet group or have the module create one from `subnet_ids`. You can supply existing source and target endpoint ARNs or have the module create endpoints from connection details (server, port, database, credentials). It is designed for tightly governed environments where security groups are managed externally and public access is not permitted.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated_storage](#input_allocated_storage) | Allocated storage in GiB for the DMS replication instance. | `number` | `100` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow_major_version_upgrade](#input_allow_major_version_upgrade) | If true, allows major engine version upgrades. | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply_immediately](#input_apply_immediately) | If true, applies modifications immediately. | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto_minor_version_upgrade](#input_auto_minor_version_upgrade) | If true, minor engine upgrades are applied automatically. | `bool` | `true` | no |
| <a name="input_engine_version"></a> [engine_version](#input_engine_version) | DMS replication engine version. | `string` | `"3.5.0"` | no |
| <a name="input_kms_key_arn"></a> [kms_key_arn](#input_kms_key_arn) | ARN of the KMS key for the DMS replication instance storage. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window) | Preferred maintenance window in UTC. | `string` | `"sun:04:00-sun:05:00"` | no |
| <a name="input_migration_type"></a> [migration_type](#input_migration_type) | Migration task type: `full-load`, `cdc`, or `full-load-and-cdc`. | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi_az](#input_multi_az) | If true, creates a Multi-AZ replication instance. | `bool` | `false` | no |
| <a name="input_replication_instance_class"></a> [replication_instance_class](#input_replication_instance_class) | Instance class for the DMS replication instance. | `string` | n/a | yes |
| <a name="input_replication_instance_id"></a> [replication_instance_id](#input_replication_instance_id) | Identifier for the DMS replication instance. | `string` | n/a | yes |
| <a name="input_replication_subnet_group_id"></a> [replication_subnet_group_id](#input_replication_subnet_group_id) | ID of an existing DMS replication subnet group. If empty, the module creates one using subnet_ids. | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | Subnet IDs for the DMS replication subnet group when the module creates it (required if replication_subnet_group_id is empty; use at least two AZs). | `list(string)` | `[]` | no |
| <a name="input_replication_task_id"></a> [replication_task_id](#input_replication_task_id) | Identifier for the DMS replication task. | `string` | n/a | yes |
| <a name="input_replication_task_settings"></a> [replication_task_settings](#input_replication_task_settings) | JSON document for advanced task settings. | `string` | `""` | no |
| <a name="input_source_endpoint_arn"></a> [source_endpoint_arn](#input_source_endpoint_arn) | ARN of an existing DMS source endpoint. If empty, the module creates one using source_* variables. | `string` | `""` | no |
| <a name="input_target_endpoint_arn"></a> [target_endpoint_arn](#input_target_endpoint_arn) | ARN of an existing DMS target endpoint. If empty, the module creates one using target_* variables. | `string` | `""` | no |
| <a name="input_source_endpoint_id"></a> [source_endpoint_id](#input_source_endpoint_id) | Identifier for the source endpoint when the module creates it. | `string` | `""` | no |
| <a name="input_source_engine_name"></a> [source_engine_name](#input_source_engine_name) | Engine name for the source (e.g. postgres, aurora-postgresql). | `string` | `""` | no |
| <a name="input_source_server_name"></a> [source_server_name](#input_source_server_name) | Hostname or IP of the source database. | `string` | `""` | no |
| <a name="input_source_port"></a> [source_port](#input_source_port) | Port of the source database. | `number` | `5432` | no |
| <a name="input_source_database_name"></a> [source_database_name](#input_source_database_name) | Name of the source database. | `string` | `""` | no |
| <a name="input_source_username"></a> [source_username](#input_source_username) | Username for the source database. | `string` | `""` | no |
| <a name="input_source_password"></a> [source_password](#input_source_password) | Password for the source database. | `string` | `""` | no |
| <a name="input_source_ssl_mode"></a> [source_ssl_mode](#input_source_ssl_mode) | SSL mode for the source: none, require, verify-ca, verify-full. | `string` | `"none"` | no |
| <a name="input_source_extra_connection_attributes"></a> [source_extra_connection_attributes](#input_source_extra_connection_attributes) | Extra connection attributes for the source endpoint. | `string` | `""` | no |
| <a name="input_target_endpoint_id"></a> [target_endpoint_id](#input_target_endpoint_id) | Identifier for the target endpoint when the module creates it. | `string` | `""` | no |
| <a name="input_target_engine_name"></a> [target_engine_name](#input_target_engine_name) | Engine name for the target (e.g. aurora-postgresql, postgres). | `string` | `""` | no |
| <a name="input_target_server_name"></a> [target_server_name](#input_target_server_name) | Hostname or IP of the target database. | `string` | `""` | no |
| <a name="input_target_port"></a> [target_port](#input_target_port) | Port of the target database. | `number` | `5432` | no |
| <a name="input_target_database_name"></a> [target_database_name](#input_target_database_name) | Name of the target database. | `string` | `""` | no |
| <a name="input_target_username"></a> [target_username](#input_target_username) | Username for the target database. | `string` | `""` | no |
| <a name="input_target_password"></a> [target_password](#input_target_password) | Password for the target database. | `string` | `""` | no |
| <a name="input_target_ssl_mode"></a> [target_ssl_mode](#input_target_ssl_mode) | SSL mode for the target: none, require, verify-ca, verify-full. | `string` | `"none"` | no |
| <a name="input_target_extra_connection_attributes"></a> [target_extra_connection_attributes](#input_target_extra_connection_attributes) | Extra connection attributes for the target endpoint. | `string` | `""` | no |
| <a name="input_table_mappings"></a> [table_mappings](#input_table_mappings) | JSON document for table selection and transformation rules. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to DMS resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc_security_group_ids](#input_vpc_security_group_ids) | List of existing VPC security group IDs for the replication instance. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replication_instance_arn"></a> [replication_instance_arn](#output_replication_instance_arn) | ARN of the DMS replication instance. |
| <a name="output_replication_task_arn"></a> [replication_task_arn](#output_replication_task_arn) | ARN of the DMS replication task. |
| <a name="output_replication_subnet_group_id"></a> [replication_subnet_group_id](#output_replication_subnet_group_id) | ID of the DMS replication subnet group in use. |
| <a name="output_source_endpoint_arn"></a> [source_endpoint_arn](#output_source_endpoint_arn) | ARN of the DMS source endpoint in use. |
| <a name="output_target_endpoint_arn"></a> [target_endpoint_arn](#output_target_endpoint_arn) | ARN of the DMS target endpoint in use. |
