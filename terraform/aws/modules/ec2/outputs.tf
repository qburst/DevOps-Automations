output "instance_id" {
  value       = aws_instance.default[*].id
  description = "The instance ID."
}

output "public_ip" {
  value       = concat(aws_eip.default[*].public_ip, aws_instance.default[*].public_ip, [""])
  description = "Public IP of instance (or EIP)."

}

output "private_ip" {
  value       = aws_instance.default[*].private_ip
  description = "Private IP of instance."
}