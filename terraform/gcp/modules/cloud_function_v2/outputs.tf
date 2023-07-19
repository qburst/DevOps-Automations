output "name" {
    value = var.function_name
}
output "bucket_name" {
  value = local.bucket_name
}
output "function_uri" {
  value = google_cloudfunctions2_function.default.service_config[0].uri
}