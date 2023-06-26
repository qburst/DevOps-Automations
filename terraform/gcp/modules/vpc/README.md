# VPC Module
This module will create a fully functional VPC via Terraform. As a part of the module it will generate the following

- 1 VPC.
- Subnet(s), based on the configuratrion
- Cloud Routers in each reageion that has a subnet requiring a NAT Gateway
- NAT Gateways for each subnet if the variable for the same is set
- Static IP addresses for each NAT gateway having manual IP allocation

## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

    module "vpc" {
    source = "/.../.../gcp/modules/vpc"
    name_prefix = "test"
    subnet_config = [
    {
        name                      = "public"
        subnet_region             = "us-central1"
        subnet_ip_cidr_range      = "10.0.0.0/24"
    },
    {
        name                      = "private"
        subnet_region             = "us-west1"
        subnet_ip_cidr_range      = "10.0.1.0/24"
        nat_gw_enabled            = true 
        nat_ip_allocate_option    = "MANUAL_ONLY"
    }
    ]
    }

## Inputs
**Important**
    All inputs :heavy_check_mark: must be configured.
    Any with :x: can be ignored, but can be configurd if you want.

    | Name        | Description | Required | Type | Default |
    | ----------- | ----------- | -------- | ---- | ------- |
    | name_prefix | All named components will have this variable added as a prefix | :x: | string | "common" |
    | subnet_config | The list of subnets being created | :x: | list(object()) | |

**subnet_config inputs**
    The subnet_config list contains objects, where each object represents a subnet. Each object has the following inputs (please see examples folder for additional references):

    | Name        | Description | Required | Type | Default |
    | ----------- | ----------- | -------- | ---- | ------- |
    | name | The name of the subnet being created | :heavy_check_mark: | string | |
    | subnet_region | The region where the subnet will be created | :heavy_check_mark: | string | |
    | subnet_ip_cidr_range| The IP and CIDR range of the subnet being created | :heavy_check_mark: | string | |
    | nat_gw_enabled | A boolean flag to enable/disable a NAT gw for the subnet | :x: | bool | false |
    | nat_ip_allocate_option | A string to select nat ip allocation option | :x: | string | "AUTO_ONLY" |


    NOTE: nat_ip_allocate_option supports only two options "AUTO_ONLY" and "MANUAL_ONLY"