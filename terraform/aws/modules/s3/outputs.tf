output "bucket_id" {
  value       = join("", aws_s3_bucket.buckets.*.id)
  description = "bucket ids"
}

output "bucket_arn" {
  value       = join("", aws_s3_bucket.buckets.*.arn)
  description = "bucket ARN"
}

output "loggin_bucket_arn" {
  value = var.logging != null ? join("", aws_s3_bucket.log_bucket.*.arn) : ""
}