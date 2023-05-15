# VPC Module
This module will create a fully functional VPC via Terraform. As a part of the module it will generate the following

- 1 VPC. Also additionally, you can attach new CIDR blocks to this VPC
- Private Subnet(s), based on the CIDRs provided
- Public Subnet(s), based on the CIDRs provided
- 1 Internet Gateway, if atleast one public subnet is created
- 1 NAT Gatewat, if the variable for the same is set
- Private and Public Route tables, for each subnet
- Associate each route table to the corresponding subnet
- Adds a route for the NAT Gateway in all private route tables, if NAT GW is enabled
- Adds a route for the Internet Gatewat in all public route tables

## Inputs
**Important**
All inputs :heavy_check_mark: must be configured.
Any with :x: can be ignored, but can be configurd if you want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| name_prefix | All named components will have this variable added as a prefix | :x: | string | "common" |
| ipv4_primary_cidr_block | the primary CIDR to be attached to the VPC | :heavy_check_mark: | string | |
| ipv4_additional_cidr_block_associations| A list of extra CIDRs to attach to the VPC | :x: | list(string) | |
| instance_tenancy | A tenancy option for instances launched into the VPC | :x: | string | default |
| dns_hostnames_enabled | A boolean flag to enable/disable DNS hostnames in the VPC | :x: | bool | true |
| dns_support_enabled | A boolean flag to enable/disable DNS support in the VPC | :x: | bool | true |
| private_subnets_cidr | A list of the CIDRs needed for the private subnet(s) | :heavy_check_mark: | list(string) | |
| public_subnets_cidr | A list of the CIDRs needed for the public subnet(s) | :heavy_check_mark: | list(string) | |
| availability_zones | A list of AZs for the subnets to be configured in. We need the number of AZs to be more or equal to the largest list of public/private cidrs. | :heavy_check_mark: | list(string) | |
| nat_gw_enabled | If set, the NAT Gateway will be launched | :x: | bool | true |

## Caveats
1. AZs. When we launch the subnets, we launch one per each value of the AZ's list. As a result we need the number of AZs to be equal or more than the private/public CIDR variable (which ever is larger). Hence the following will fail
```
  public_subnets_cidr                     = ["172.20.0.0/20", "172.20.16.0/20"]
  private_subnets_cidr                    = ["172.21.0.0/20"]
  availability_zones                      = ["ap-south-1a"]
```
And would need to be configured instead as 
```
  public_subnets_cidr                     = ["172.20.0.0/20", "172.20.16.0/20"]
  private_subnets_cidr                    = ["172.21.0.0/20"]
  availability_zones                      = ["ap-south-1a", "ap-south-1a"]
```
2. We assume that if you are creating a public subnet, you need an internet gateway and always launch the same. If you have a use case where this is not so, please create a variable for the same.
3. We assume that all public subnets need the IGW to be associated to the same. If this is not so, the route for IGW needs to be changed. The same also applies for NAT GW and private subnets.
4. We assume you only need one IGW and one NAT GW each. But in significantly larger environments, this wont be enough. In such cases you will need to tweak the count logics and aws_route logic accordingly.
