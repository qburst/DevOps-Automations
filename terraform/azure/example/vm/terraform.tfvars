
vm_name          = "my-vm"
location         = "East US"
resource_group_name = "rg-sample"
vm_size          = "Standard_B1s"
publisher = "Canonical"
offer = "UbuntuServer"
sku="20.04 LTS"
version="latest"
admin_username   = "adminuser"
admin_password   = "P@ssw0rd123"
tags = {
  environment = "development"
}