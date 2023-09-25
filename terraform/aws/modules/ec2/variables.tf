# EC2
variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-08e5424edfe926b43"
}

variable "number_of_instances" {
  description = "number of instances to be created"
  default     = 1
}


variable "ami_key_pair_name" {
  default = "ec2-terraform"
}

variable "instance-tag-name" {
  description = "instance-tag-name"
  type        = string
  default     = "EC2-instance-created-with-terraform"
}

variable "instance-associate-public-ip" {
  description = "Defines if the EC2 instance has a public IP address."
  type        = string
  default     = "true"
}

# IAM
variable "iam-role-name" {
  default = ""
}

# EIP
variable "alloc_id" {
  default = "eipalloc-0b2333a222698de3d"
}

# SG
variable "ingress_rules" {
  default = {
    "http ingress rule" = {
      "description" = "For HTTP"
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    "ssh ingress rule" = {
      "description" = "For SSH"
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  }
  type        = map(any)
  description = "Security group rules"
}

variable "egress_rules" {
  default = {
    "http ingress rule" = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  } }
  type        = map(any)
  description = "Security group rules"
}

# SUBNET
variable "subnet-id" {
  default = ""
}

# DISK
variable "root_volume_type" {
  default = "gp2"
}

variable "root_volume_size" {
  default = "8"
} 

variable "disk-tag-name" {
  description = "terraform vol"
  type        = string
  default     = "terraform-vol"
}

variable "ec2_additional_ebs_volume_count" {
  description = "secondary volume"
  default = 1 # only 0 or 1 supported
}

variable "ec2_additional_ebs_volume_size" {
  default = 2
}

variable "role_arn" {
  description = "Role arn to attach"
  type        = string
  default     = "arn:aws:iam::375934664445:role/test-terraform"
}