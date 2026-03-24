# AWS ECR Repository Module

This module creates an AWS Elastic Container Registry (ECR) repository with KMS encryption enabled and optional image scanning on push. It is suitable for tightly governed environments where image immutability and encryption at rest are required.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag_mutability"></a> [image_tag_mutability](#input_image_tag_mutability) | Tag mutability setting for the repository (`MUTABLE` or `IMMUTABLE`). | `string` | `"IMMUTABLE"` | no |
| <a name="input_kms_key_arn"></a> [kms_key_arn](#input_kms_key_arn) | ARN of the KMS key used to encrypt images at rest in the ECR repository. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | Name of the ECR repository. | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan_on_push](#input_scan_on_push) | If true, enables image scanning on push. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Map of tags to apply to the ECR repository. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_arn"></a> [repository_arn](#output_repository_arn) | ARN of the ECR repository. |
| <a name="output_repository_url"></a> [repository_url](#output_repository_url) | URL of the ECR repository. |

