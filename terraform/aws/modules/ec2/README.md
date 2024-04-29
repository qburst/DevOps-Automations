# AWS EC2 Module
This module sets up an EC2 server in your account. It also can be used to launch a spot instance if you wish.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip"></a> [allowed\_ip](#input\_allowed\_ip) | List of allowed ip. | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | List of allowed ingress ports | `list(any)` | <pre>[<br>  80,<br>  443<br>]</pre> | no |
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the instance. If not set the module will try to use the latest Ubuntu 22.04 image | `string` | `""` | no |
| <a name="input_assign_eip_address"></a> [assign\_eip\_address](#input\_assign\_eip\_address) | Assign an Elastic IP address to the instance. | `bool` | `false` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address with the instance. | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | AZ to start the instance in | `string` | `null` | no |
| <a name="input_cpu_core_count"></a> [cpu\_core\_count](#input\_cpu\_core\_count) | Sets the number of CPU cores for an instance. | `string` | `null` | no |
| <a name="input_cpu_options"></a> [cpu\_options](#input\_cpu\_options) | Defines CPU options to apply to the instance at launch time. | `any` | `{}` | no |
| <a name="input_cpu_threads_per_core"></a> [cpu\_threads\_per\_core](#input\_cpu\_threads\_per\_core) | Sets the number of CPU threads per core for an instance (has no effect unless cpu\_core\_count is also set) | `number` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection. | `bool` | `false` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | The Zone ID of Route53. If this is set, a DNS record is created for the instance. | `string` | `""` | no |
| <a name="input_ebs_device_name"></a> [ebs\_device\_name](#input\_ebs\_device\_name) | Name of the EBS device to mount. | `list(string)` | <pre>[<br>  "/dev/xvdb",<br>  "/dev/xvdc"<br>]</pre> | no |
| <a name="input_ebs_iops"></a> [ebs\_iops](#input\_ebs\_iops) | Amount of provisioned IOPS. This must be set with a volume\_type of io1. | `number` | `0` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized. | `bool` | `false` | no |
| <a name="input_ebs_volume_enabled"></a> [ebs\_volume\_enabled](#input\_ebs\_volume\_enabled) | Flag to control the ebs creation. | `bool` | `false` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | Size of the EBS volume in gigabytes. | `number` | `30` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | The type of EBS volume. Can be standard, gp2 or io1. | `string` | `"gp2"` | no |
| <a name="input_egress_ipv4_cidr_block"></a> [egress\_ipv4\_cidr\_block](#input\_egress\_ipv4\_cidr\_block) | List of CIDR blocks. Cannot be specified with source\_security\_group\_id or self. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv4_from_port"></a> [egress\_ipv4\_from\_port](#input\_egress\_ipv4\_from\_port) | Egress Start port (or ICMP type number if protocol is icmp or icmpv6). | `number` | `0` | no |
| <a name="input_egress_ipv4_protocol"></a> [egress\_ipv4\_protocol](#input\_egress\_ipv4\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_ipv4_to_port"></a> [egress\_ipv4\_to\_port](#input\_egress\_ipv4\_to\_port) | Egress end port (or ICMP code if protocol is icmp). | `number` | `65535` | no |
| <a name="input_egress_ipv6_cidr_block"></a> [egress\_ipv6\_cidr\_block](#input\_egress\_ipv6\_cidr\_block) | List of CIDR blocks. Cannot be specified with source\_security\_group\_id or self. | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_from_port"></a> [egress\_ipv6\_from\_port](#input\_egress\_ipv6\_from\_port) | Egress Start port (or ICMP type number if protocol is icmp or icmpv6). | `number` | `0` | no |
| <a name="input_egress_ipv6_protocol"></a> [egress\_ipv6\_protocol](#input\_egress\_ipv6\_protocol) | Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"-1"` | no |
| <a name="input_egress_ipv6_to_port"></a> [egress\_ipv6\_to\_port](#input\_egress\_ipv6\_to\_port) | Egress end port (or ICMP code if protocol is icmp). | `number` | `65535` | no |
| <a name="input_egress_rule"></a> [egress\_rule](#input\_egress\_rule) | Enable to create egress rule | `bool` | `true` | no |
| <a name="input_enable_security_group"></a> [enable\_security\_group](#input\_enable\_security\_group) | Enable default Security Group with only Egress traffic allowed. | `bool` | `true` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | If true, wait for password data to become available and retrieve it | `bool` | `null` | no |
| <a name="input_host_id"></a> [host\_id](#input\_host\_id) | The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host. | `string` | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | DNS records to create. | `string` | `"ec2"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM Instance Profile to launch the instance with. If not specified, the IAM profile is not set. | `string` | `""` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch. | `number` | `1` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The base name of all instances being created | `string` | `"ec2-test"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | `"t2.micro"` | no |
| <a name="input_ipv6_address_count"></a> [ipv6\_address\_count](#input\_ipv6\_address\_count) | Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. | `number` | `null` | no |
| <a name="input_ipv6_addresses"></a> [ipv6\_addresses](#input\_ipv6\_addresses) | List of IPv6 addresses from the range of the subnet to associate with the primary network interface. | `list(any)` | `null` | no |
| <a name="input_is_external"></a> [is\_external](#input\_is\_external) | enable to udated existing security Group | `bool` | `false` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | This map has all the variables needed for using KMS | `map(any)` | <pre>{<br>  "alias": null,<br>  "deletion_window_in_days": 7,<br>  "description": "KMS master key",<br>  "enabled": true,<br>  "id": "",<br>  "multi_region": false<br>}</pre> | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled. | `bool` | `false` | no |
| <a name="input_multi_attach_enabled"></a> [multi\_attach\_enabled](#input\_multi\_attach\_enabled) | Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on io1 and io2 volumes. | `bool` | `false` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details. | `list(any)` | `[]` | no |
| <a name="input_secondary_private_ips"></a> [secondary\_private\_ips](#input\_secondary\_private\_ips) | A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block` | `list(string)` | `null` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| <a name="input_sg_egress_description"></a> [sg\_egress\_description](#input\_sg\_egress\_description) | Description of the egress and ingress rule | `string` | `"Description of the rule."` | no |
| <a name="input_sg_egress_ipv6_description"></a> [sg\_egress\_ipv6\_description](#input\_sg\_egress\_ipv6\_description) | Description of the egress\_ipv6 rule | `string` | `"Description of the rule."` | no |
| <a name="input_sg_ids"></a> [sg\_ids](#input\_sg\_ids) | List of the security group ids, in case they already exist | `list(any)` | `[]` | no |
| <a name="input_sg_ingress_description"></a> [sg\_ingress\_description](#input\_sg\_ingress\_description) | Description of the ingress rule | `string` | `"Description of the ingress rule use elasticache."` | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. | `bool` | `true` | no |
| <a name="input_spot_block_duration_minutes"></a> [spot\_block\_duration\_minutes](#input\_spot\_block\_duration\_minutes) | The required duration for the Spot instances, in minutes. This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360) | `number` | `null` | no |
| <a name="input_spot_instance_count"></a> [spot\_instance\_count](#input\_spot\_instance\_count) | Number of instances to launch. | `number` | `0` | no |
| <a name="input_spot_instance_enabled"></a> [spot\_instance\_enabled](#input\_spot\_instance\_enabled) | Flag to control the instance creation. | `bool` | `true` | no |
| <a name="input_spot_instance_interruption_behavior"></a> [spot\_instance\_interruption\_behavior](#input\_spot\_instance\_interruption\_behavior) | Indicates Spot instance behavior when it is interrupted. Valid values are `terminate`, `stop`, or `hibernate` | `string` | `null` | no |
| <a name="input_spot_launch_group"></a> [spot\_launch\_group](#input\_spot\_launch\_group) | A launch group is a group of spot instances that launch together and terminate together. If left empty instances are launched and terminated individually | `string` | `null` | no |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | The maximum price to request on the spot market. Defaults to on-demand price | `string` | `null` | no |
| <a name="input_spot_type"></a> [spot\_type](#input\_spot\_type) | If set to one-time, after the instance is terminated, the spot request will be closed. Default `persistent` | `string` | `null` | no |
| <a name="input_spot_valid_from"></a> [spot\_valid\_from](#input\_spot\_valid\_from) | The start date and time of the request, in UTC RFC3339 format(for example, YYYY-MM-DDTHH:MM:SSZ) | `string` | `null` | no |
| <a name="input_spot_valid_until"></a> [spot\_valid\_until](#input\_spot\_valid\_until) | The end date and time of the request, in UTC RFC3339 format(for example, YYYY-MM-DDTHH:MM:SSZ) | `string` | `null` | no |
| <a name="input_spot_wait_for_fulfillment"></a> [spot\_wait\_for\_fulfillment](#input\_spot\_wait\_for\_fulfillment) | If set, Terraform will wait for the Spot Request to be fulfilled, and will throw an error if the timeout of 10m is reached | `bool` | `false` | no |
| <a name="input_ssh_allowed_ip"></a> [ssh\_allowed\_ip](#input\_ssh\_allowed\_ip) | List of allowed ip. | `list(any)` | `[]` | no |
| <a name="input_ssh_allowed_ports"></a> [ssh\_allowed\_ports](#input\_ssh\_allowed\_ports) | List of allowed ingress ports | `list(any)` | `[]` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | `map(any)` | <pre>{<br>  "algorithm": "RSA",<br>  "key_name": "",<br>  "public_key": "",<br>  "rsa_bits": 4096<br>}</pre> | no |
| <a name="input_ssh_protocol"></a> [ssh\_protocol](#input\_ssh\_protocol) | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| <a name="input_ssh_sg_ingress_description"></a> [ssh\_sg\_ingress\_description](#input\_ssh\_sg\_ingress\_description) | Description of the ingress rule | `string` | `"Description of the ingress rule use elasticache."` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC Subnet IDs to launch in. | `list(string)` | `[]` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of 'dedicated' runs on single-tenant hardware. Valid values are 'default', 'dedicated', and 'host' | `string` | `"default"` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The TTL of the record to add to the DNS zone to complete certificate validation. | `string` | `"300"` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of DNS records to create. | `string` | `"CNAME"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | (Optional) A string of the desired User Data for the ec2. | `string` | `""` | no |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | When used in combination with user\_data or user\_data\_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set | `bool` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The instance ID. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of instance. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP of instance (or EIP). |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | n/a |
| <a name="output_ssh_public_key"></a> [ssh\_public\_key](#output\_ssh\_public\_key) | n/a |
