variable "instance_name" {
  type        = string
  default     = "ec2-test"
  description = "The base name of all instances being created"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of instances to launch."
}

variable "ami" {
  type        = string
  default     = ""
  description = "The AMI to use for the instance. If not set the module will try to use the latest Ubuntu 22.04 image"
}

variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will be EBS-optimized."
}

variable "instance_type" {
  type        = string
  default     = "t2-micro"
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Associate a public IP address with the instance."
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "If true, enables EC2 Instance Termination Protection."
}

variable "tenancy" {
  type        = string
  default     = "default"
  description = "The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of 'dedicated' runs on single-tenant hardware. Valid values are 'default', 'dedicated', and 'host'"
}

variable "root_block_device" {
  type        = list(any)
  default     = []
  description = "Customize details about the root block device of the instance. See Block Devices below for details."
}

variable "user_data" {
  type        = string
  default     = ""
  description = "(Optional) A string of the desired User Data for the ec2."
}

variable "assign_eip_address" {
  type        = bool
  default     = true
  description = "Assign an Elastic IP address to the instance."
  sensitive   = true
}

variable "ebs_iops" {
  type        = number
  default     = 0
  description = "Amount of provisioned IOPS. This must be set with a volume_type of io1."
}

variable "ebs_device_name" {
  type        = list(string)
  default     = ["/dev/xvdb", "/dev/xvdc"]
  description = "Name of the EBS device to mount."
}

variable "ebs_volume_size" {
  type        = number
  default     = 30
  description = "Size of the EBS volume in gigabytes."
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "The type of EBS volume. Can be standard, gp2 or io1."
}

variable "ebs_volume_enabled" {
  type        = bool
  default     = false
  description = "Flag to control the ebs creation."
}

variable "iam_instance_profile" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with. If not specified, the IAM profile is not set."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC Subnet IDs to launch in."
}

variable "source_dest_check" {
  type        = bool
  default     = true
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
}

variable "ipv6_address_count" {
  type        = number
  default     = null
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
}

variable "ipv6_addresses" {
  type        = list(any)
  default     = null
  description = "List of IPv6 addresses from the range of the subnet to associate with the primary network interface."
  sensitive   = true
}

variable "host_id" {
  type        = string
  default     = null
  description = "The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
}

variable "cpu_core_count" {
  type        = string
  default     = null
  description = "Sets the number of CPU cores for an instance."
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "The Zone ID of Route53. If this is set, a DNS record is created for the instance."
  sensitive   = true
}

variable "hostname" {
  type        = string
  default     = "ec2"
  description = "DNS records to create."
}

variable "type" {
  type        = string
  default     = "CNAME"
  description = "Type of DNS records to create."
}

variable "ttl" {
  type        = string
  default     = "300"
  description = "The TTL of the record to add to the DNS zone to complete certificate validation."
}

variable "multi_attach_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on io1 and io2 volumes."
}

variable "kms_key" {
  type        = map(any)
  description = "This map has all the variables needed for using KMS"
  default = {
    enabled                 = true
    description             = "KMS master key" # The description of the key
    id                      = ""               # The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption.
    alias                   = "alias/ec2-test" # The display name of the alias.
    deletion_window_in_days = 7
    multi_region            = false # Indicates whether the key is a multi-Region (true) or regional (false) key
  }
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "allowed_ip" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "List of allowed ip."
}

variable "allowed_ports" {
  type        = list(any)
  default     = [80, 443]
  description = "List of allowed ingress ports"
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "egress_rule" {
  type        = bool
  default     = true
  description = "Enable to create egress rule"
}

variable "is_external" {
  type        = bool
  default     = false
  description = "enable to udated existing security Group"
}

variable "sg_ids" {
  type        = list(any)
  default     = []
  description = "List of the security group ids, in case they already exist"
}

variable "sg_description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}

variable "sg_egress_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress and ingress rule"
}

variable "sg_egress_ipv6_description" {
  type        = string
  default     = "Description of the rule."
  description = "Description of the egress_ipv6 rule"
}

variable "sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use elasticache."
  description = "Description of the ingress rule"
}

variable "ssh_allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "ssh_allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "ssh_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "ssh_sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use elasticache."
  description = "Description of the ingress rule"
}

variable "ssh_key" {
  type = map(any)
  default = {
    key_name   = "" # Key name of the Key Pair to use for the instance; if not specified it will create a new key pair.
    public_key = "" # the public key of the key pair (e.g. `ssh-rsa AABBCCDDEE44554422`).
    algorithm  = "RSA"
    rsa_bits   = 4096
  }
}

###### spot
variable "spot_instance_enabled" {
  type        = bool
  default     = true
  description = "Flag to control the instance creation."
}

variable "spot_instance_count" {
  type        = number
  default     = 0
  description = "Number of instances to launch."
}

variable "spot_price" {
  type        = string
  default     = null
  description = "The maximum price to request on the spot market. Defaults to on-demand price"
}

variable "spot_wait_for_fulfillment" {
  type        = bool
  default     = false
  description = "If set, Terraform will wait for the Spot Request to be fulfilled, and will throw an error if the timeout of 10m is reached"
}

variable "spot_type" {
  type        = string
  default     = null
  description = "If set to one-time, after the instance is terminated, the spot request will be closed. Default `persistent`"
}

variable "spot_launch_group" {
  type        = string
  default     = null
  description = "A launch group is a group of spot instances that launch together and terminate together. If left empty instances are launched and terminated individually"
}

variable "spot_block_duration_minutes" {
  type        = number
  default     = null
  description = "The required duration for the Spot instances, in minutes. This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360)"
}

variable "spot_instance_interruption_behavior" {
  type        = string
  default     = null
  description = "Indicates Spot instance behavior when it is interrupted. Valid values are `terminate`, `stop`, or `hibernate`"
}

variable "spot_valid_until" {
  type        = string
  default     = null
  description = "The end date and time of the request, in UTC RFC3339 format(for example, YYYY-MM-DDTHH:MM:SSZ)"
}

variable "spot_valid_from" {
  type        = string
  default     = null
  description = "The start date and time of the request, in UTC RFC3339 format(for example, YYYY-MM-DDTHH:MM:SSZ)"
}

variable "cpu_threads_per_core" {
  description = "Sets the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)"
  type        = number
  default     = null
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set"
  type        = bool
  default     = null
}

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it"
  type        = bool
  default     = null
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block`"
  type        = list(string)
  default     = null
}

variable "egress_ipv4_from_port" {
  description = "Egress Start port (or ICMP type number if protocol is icmp or icmpv6)."
  type        = number
  default     = 0
}

variable "egress_ipv4_to_port" {
  description = "Egress end port (or ICMP code if protocol is icmp)."
  type        = number
  default     = 65535
}

variable "egress_ipv4_protocol" {
  description = "Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "-1"
}

variable "egress_ipv4_cidr_block" {
  description = " List of CIDR blocks. Cannot be specified with source_security_group_id or self."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_from_port" {
  description = "Egress Start port (or ICMP type number if protocol is icmp or icmpv6)."
  type        = number
  default     = 0
}

variable "egress_ipv6_to_port" {
  description = "Egress end port (or ICMP code if protocol is icmp)."
  type        = number
  default     = 65535
}

variable "egress_ipv6_protocol" {
  description = "Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "-1"
}

variable "egress_ipv6_cidr_block" {
  description = " List of CIDR blocks. Cannot be specified with source_security_group_id or self."
  type        = list(string)
  default     = ["::/0"]
}

variable "cpu_options" {
  description = "Defines CPU options to apply to the instance at launch time."
  type        = any
  default     = {}
}