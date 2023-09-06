#To create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#To create virtual network
resource "azurerm_virtual_network" "Vnet" {
  name                = var.vnetwork_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

#To create subnets
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_address_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.aks_subnet_address_prefix]
}
 
resource "azurerm_subnet" "appgw_subnet" {
  name                 = var.appgw_subnet_address_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.appgw_subnet_address_prefix]
}

#To create network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#To create network security group association
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

