output "service" {
  value = var.service_name
}

output "cloud_run_uri" {
  value = google_cloud_run_v2_service.with_vpc_access.uri
}