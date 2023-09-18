module "azure_aks" {
  source                = "./modules/azure-aks"
  resource_group_name   = var.resource_group_name
  location              = var.location
  cluster_name          = "my-aks-cluster"
  dns_prefix            = "myaksclusterdns"
  node_count            = 3
  node_vm_size          = "Standard_DS2_v2"
  tags                  = { environment = "dev", owner = "myuser" }
}