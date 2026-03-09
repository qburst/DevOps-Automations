# AWS Internal ALB Module

This module creates an internal AWS Application Load Balancer (ALB) with an HTTPS listener and a single target group. It is designed for private, trusted subnets in a governed landing zone, where security groups and certificates are managed centrally.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate_arn](#input_certificate_arn) | ARN of the ACM certificate used by the HTTPS listener. | `string` | n/a | yes |
| <a name="input_health_check_healthy_threshold"></a> [health_check_healthy_threshold](#input_health_check_healthy_threshold) | Number of consecutive health check successes before a target is considered healthy. | `number` | `3` | no |
| <a name="input_health_check_interval"></a> [health_check_interval](#input_health_check_interval) | Interval between health checks, in seconds. | `number` | `30` | no |
| <a name="input_health_check_matcher"></a> [health_check_matcher](#input_health_check_matcher) | HTTP status code matcher for health checks. | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health_check_path](#input_health_check_path) | Path for HTTP health checks. | `string` | `"/"` | no |
| <a name="input_health_check_timeout"></a> [health_check_timeout](#input_health_check_timeout) | Health check timeout, in seconds. | `number` | `5` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health_check_unhealthy_threshold](#input_health_check_unhealthy_threshold) | Number of consecutive health check failures before a target is considered unhealthy. | `number` | `3` | no |
| <a name="input_idle_timeout"></a> [idle_timeout](#input_idle_timeout) | Idle timeout for the ALB, in seconds. | `number` | `60` | no |
| <a name="input_name"></a> [name](#input_name) | Name of the internal Application Load Balancer. | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security_group_ids](#input_security_group_ids) | List of existing security group IDs to associate with the ALB. | `list(string)` | n/a | yes |
| <a name="input_ssl_policy"></a> [ssl_policy](#input_ssl_policy) | SSL policy name for the HTTPS listener. | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids) | List of private or trusted subnet IDs where the ALB will be placed. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to ALB resources. | `map(string)` | `{}` | no |
| <a name="input_target_group_name"></a> [target_group_name](#input_target_group_name) | Name of the target group associated with the ALB. | `string` | n/a | yes |
| <a name="input_target_group_port"></a> [target_group_port](#input_target_group_port) | Port the target group forwards traffic to. | `number` | n/a | yes |
| <a name="input_target_type"></a> [target_type](#input_target_type) | Type of targets for the target group (`instance`, `ip`, or `lambda`). | `string` | `"ip"` | no |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id) | ID of the VPC where the ALB and target group are created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb_arn](#output_alb_arn) | ARN of the internal ALB. |
| <a name="output_alb_dns_name"></a> [alb_dns_name](#output_alb_dns_name) | DNS name of the internal ALB. |
| <a name="output_target_group_arn"></a> [target_group_arn](#output_target_group_arn) | ARN of the associated target group. |

