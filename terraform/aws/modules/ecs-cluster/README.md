# AWS ECS Cluster Module

This module creates an AWS ECS cluster that can be used to run Fargate services and, in the future, EC2 Auto Scaling group-based services. It is designed to integrate into a pre-provisioned, tightly governed landing zone where networking and security controls are managed centrally.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input_name) | Name of the ECS cluster to create. | `string` | n/a | yes |
| <a name="input_enable_container_insights"></a> [enable_container_insights](#input_enable_container_insights) | If true, enables CloudWatch Container Insights for the ECS cluster. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to the ECS cluster. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster_arn](#output_cluster_arn) | ARN of the ECS cluster. |
| <a name="output_cluster_id"></a> [cluster_id](#output_cluster_id) | ID of the ECS cluster. |
| <a name="output_cluster_name"></a> [cluster_name](#output_cluster_name) | Name of the ECS cluster. |

