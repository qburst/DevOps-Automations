module "vpc" {
  source      = "/.../.../gcp/modules/vpc"
  name_prefix = "test2"
  subnet_config = [
    #subnet 1: 
    {
      name                 = "public"
      subnet_region        = "us-central1"
      subnet_ip_cidr_range = "10.0.0.0/24"
    },
    #subnet 2:  
    {
      name                 = "private"
      subnet_region        = "us-west1"
      subnet_ip_cidr_range = "10.0.1.0/24"
      nat_gw_enabled       = true
    },
    #subnet 3:  
    {
      name                   = "private2"
      subnet_region          = "us-west1"
      subnet_ip_cidr_range   = "10.0.2.0/24"
      nat_gw_enabled         = true
      nat_ip_allocate_option = "MANUAL_ONLY"

    },
    #subnet 4:  
    {
      name                 = "private3"
      subnet_region        = "us-central1"
      subnet_ip_cidr_range = "10.0.3.0/24"
      nat_gw_enabled       = true
    }
  ]
}

output "vpc_module_outputs" {
  value = module.vpc
}