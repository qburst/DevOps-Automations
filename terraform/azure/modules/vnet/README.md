
# Azure Virtual Network (VNet) Module

This Terraform module creates an Azure Virtual Network (VNet) along with subnets, a network security group (NSG), and associated security rules in Azure. It simplifies the provisioning of network resources for your Azure infrastructure.

## Features

- Creates an Azure Virtual Network (VNet) with customizable settings.
- Defines subnets within the VNet with flexible address prefixes.
- Configures a Network Security Group (NSG) with inbound and outbound security rules.
- Supports easy customization of security rules based on your requirements.
- Modular design for reusability across different Azure environments.

## Usage

```hcl
module "azure_vnet" {
  source = "./azure_vnet_module"  # Replace with the actual path to the module directory

  # Input variables
  resource_group_name     = "my-resource-group"
  vnet_name               = "my-vnet"
  address_space           = ["10.0.0.0/16"]
  location                = "East US"
  subnet_names            = ["subnet1", "subnet2"]
  subnet_address_prefixes = ["10.0.1.0/24", "10.0.2.0/24"]
  nsg_name                = "my-nsg"

  inbound_rules = {
    rule1 = {
      name                        = "inbound_rule1"
      priority                    = 100
      access                      = "Allow"
      protocol                    = "TCP"
      source_port_range           = "*"
      destination_port_range      = "80"
      source_address_prefix       = "1.2.3.4"
      destination_address_prefix  = "10.0.1.0/24"
    }
  }

  outbound_rules = {
    rule1 = {
      name                        = "outbound_rule1"
      priority                    = 100
      access                      = "Allow"
      protocol                    = "TCP"
      source_port_range           = "*"
      destination_port_range      = "443"
      source_address_prefix       = "10.0.1.0/24"
      destination_address_prefix  = "5.6.7.8"
    }
  }
}
```

## Inputs

| Name                   | Description                                  | Type       | Default | Required |
|------------------------|----------------------------------------------|------------|---------|----------|
| `resource_group_name`  | Name of the Azure Resource Group.            | `string`   |         | Yes      |
| `vnet_name`            | Name of the Azure Virtual Network.           | `string`   |         | Yes      |
| `address_space`        | Address space for the VNet.                  | `list(string)` |   | Yes      |
| `location`             | Azure region where resources will be created.| `string`   |         | Yes      |
| `subnet_names`         | List of subnet names.                        | `list(string)` |     | Yes      |
| `subnet_address_prefixes` | List of subnet address prefixes.         | `list(string)` |     | Yes      |
| `nsg_name`             | Name of the Network Security Group (NSG).   | `string`   |         | Yes      |
| `inbound_rules`        | Map of inbound security rules.               | `map(object)`  |         | Yes      |
| `outbound_rules`       | Map of outbound security rules.              | `map(object)`  |         | Yes      |

## Outputs

| Name        | Description                                       |
|-------------|---------------------------------------------------|
| `vnet_id`   | The ID of the created Azure Virtual Network.     |
| `subnet_ids`| List of IDs of the created subnets.              |
