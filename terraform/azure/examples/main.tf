module "network" {
  source                  = "../modules/vnet"
  vnet_name               = "myvnet"
  address_space           = ["10.0.0.0/16"]
  location                = "eastus"
  resource_group_name     = "testrg"
  subnet_names            = ["aks_subnet", "appgw_subnet"]
  subnet_address_prefixes = ["10.0.1.0/24", "10.0.2.0/24"]
  nsg_name                = "testnsg"

  inbound_rules = {
    rule1 = {
      name                       = "inbound_rule1"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "1.2.3.4"
      destination_address_prefix = "10.0.1.0/24"
    }
  }

  outbound_rules = {
    rule1 = {
      name                       = "outbound_rule1"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "5.6.7.8"
    }
  }
}
