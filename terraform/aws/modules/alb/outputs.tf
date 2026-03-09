output "alb_arn" {
  description = "ARN of the internal Application Load Balancer."
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the internal Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group associated with the ALB."
  value       = aws_lb_target_group.this.arn
}

