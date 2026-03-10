# AWS KMS Key Module

This module creates a single-region KMS key and alias. It is designed for governed environments (no multi-region, no external sharing). Optionally provide a custom key policy.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [alias_name](#input_alias_name) | Name for the KMS alias (without 'alias/' prefix). | `string` | n/a | yes |
| [description](#input_description) | Description of the KMS key. | `string` | n/a | yes |
| [deletion_window_in_days](#input_deletion_window_in_days) | Number of days to retain the key after deletion. | `number` | `7` | no |
| [enable_key_rotation](#input_enable_key_rotation) | Whether to enable automatic key rotation. | `bool` | `false` | no |
| [policy](#input_policy) | Key policy JSON. If null, uses default root-only policy. | `string` | `null` | no |
| [tags](#input_tags) | Tags to apply to the KMS key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| [key_arn](#output_key_arn) | ARN of the KMS key. |
| [key_id](#output_key_id) | ID of the KMS key. |
| [alias_name](#output_alias_name) | Alias name of the KMS key. |
