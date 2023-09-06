module "network" {
  source            = "./modules/azure_vnet"  
  vnet_name         = "myvnet"
  address_space     = ["10.0.0.0/16"]
  location          = "us-east-1"
  resource_group_name = "testrg"
  subnet_names      = ["subnet1", "subnet2"]
  subnet_address_prefixes = ["10.0.1.0/24", "10.0.2.0/24"]
}

