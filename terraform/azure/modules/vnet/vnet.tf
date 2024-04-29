#To create resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Name        = var.resource_group_name
    Environment = "${local.environment}"
  }
}

#To create virtual network
resource "azurerm_virtual_network" "Vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  tags = {
    Name        = var.vnet_name
    Environment = "${local.environment}"
  }
}

#To create subnets
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
}

#To create network security group
resource "azurerm_network_security_group" "default_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  tags = {
    Name        = var.nsg_name
    Environment = "${local.environment}"
  }
}

#To add inbound rules
resource "azurerm_network_security_rule" "inbound" {
  for_each = var.inbound_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
}

#To add outbound rules
resource "azurerm_network_security_rule" "outbound" {
  for_each = var.outbound_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Outbound"
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.default_nsg.name
}

#To create network security group association
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = length(azurerm_subnet.subnets)
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.default_nsg.id
}

