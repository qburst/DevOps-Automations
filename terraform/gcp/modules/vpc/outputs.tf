output "vpc_id" {
  value       = google_compute_network.default.*.id
  description = "The ID of the VPC created"
}

output "subnet_id" {
  value       = google_compute_subnetwork.default.*.id
  description = "The ID of the subnets created"
}

output "manual_nat_ips" {
  value       = google_compute_address.address.*.address
  description = "The IPs allocated to manual nats"
}