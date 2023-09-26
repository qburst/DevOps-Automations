output "instance_id" {
  value       = google_compute_instance.compute_engine.id
  description = "The ID of the Instance created"
}