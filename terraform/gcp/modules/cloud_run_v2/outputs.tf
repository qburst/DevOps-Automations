output "service" {
  value = var.service_name
}

output "cloud_run_uri" {
  value = length(var.vpc_connector) > 0 ? google_cloud_run_v2_service.with_vpc_access[0].uri : google_cloud_run_v2_service.default[0].uri
}