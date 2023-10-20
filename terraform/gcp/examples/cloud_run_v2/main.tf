module "run_v2_service" {
  source         = "/.../.../gcp/modules/cloud_run_v2"
  service_name   = "test-service"
  location       = "asia-south1"
  vpc_connector  = "run-connector"
  make_public    = true
  img_url        = "us-docker.pkg.dev/cloudrun/container/hello"
  container_port = 8080
}

module "run_v2_service2" {
  source             = "/.../.../gcp/modules/cloud_run_v2"
  service_name       = "test-service2"
  location           = "us-central1"
  make_public        = true
  img_url            = "dpage/pgadmin4"
  min_instance_count = 1
  max_instance_count = 3
  container_port     = 80
  container_env = [{ key = "PGADMIN_DEFAULT_EMAIL", value = "indrajithks538@gmail.com" },
    { key = "PGADMIN_DEFAULT_PASSWORD", value = "Admin123" },
  { key = "PGADMIN_LISTEN_PORT", value = "80" }]
}



output "cloud_run_v2_module_outputs1" {
  value = module.run_v2_service
}

output "cloud_run_v2_module_outputs2" {
  value = module.run_v2_service2
}