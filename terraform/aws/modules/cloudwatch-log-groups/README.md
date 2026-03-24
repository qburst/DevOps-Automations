# AWS CloudWatch Log Groups Module

This module creates one or more AWS CloudWatch log groups with KMS encryption enabled and a configurable retention period. It is intended for landing zones that require encrypted logs and centrally managed retention.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_arn"></a> [kms_key_arn](#input_kms_key_arn) | ARN of the KMS key used to encrypt log groups at rest. Key policy must allow CloudWatch Logs service principal (`logs.region.amazonaws.com`). | `string` | n/a | yes |
| <a name="input_log_group_names"></a> [log_group_names](#input_log_group_names) | List of CloudWatch log group names to create. | `list(string)` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention_in_days](#input_retention_in_days) | Number of days to retain logs. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to log groups. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_names"></a> [log_group_names](#output_log_group_names) | Names of the CloudWatch log groups created. |

