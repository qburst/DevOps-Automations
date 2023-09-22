module "compute_engine" {
  source       = "/../../gcp/modules/compute_engine"
  name         = "Qburst-DevOps"
  machine_type = "e2-medium"
  image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  zone         = "us-central1-a"
  network      = "10.1.1.0"

}

output "computeengine_module_outputs" {
  value = module.compute_engine
}