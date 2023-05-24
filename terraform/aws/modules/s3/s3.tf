resource "aws_s3_bucket" "buckets" {
  count         = length(var.bucket_name) != 0 ? length(var.bucket_name) : 0
  bucket        = var.bucket_name[count.index]
  force_destroy = var.force_destroy
}

# This bucket is used for logging only
resource "aws_s3_bucket" "log_bucket" {
  count         = var.logging != null ? 1 : 0
  bucket        = var.logging["bucket_name"]
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_logging" "default" {
  count         = var.logging != null ? length(var.bucket_name) : 0
  bucket        = aws_s3_bucket.buckets[count.index].id
  target_bucket = var.logging["bucket_name"]
  target_prefix = var.logging["prefix"]
}

resource "aws_s3_bucket_public_access_block" "default" {
  count                   = length(var.bucket_name) != 0 ? length(var.bucket_name) : 0
  bucket                  = aws_s3_bucket.buckets[count.index].id
  block_public_acls       = var.public_access_block["block_public_acls"]
  block_public_policy     = var.public_access_block["block_public_policy"]
  ignore_public_acls      = var.public_access_block["ignore_public_acls"]
  restrict_public_buckets = var.public_access_block["restrict_public_buckets"]
}

resource "aws_s3_bucket_public_access_block" "logging" {
  count                   = var.logging != null ? 1 : 0
  bucket                  = aws_s3_bucket.log_bucket[count.index].id
  block_public_acls       = var.public_access_block["block_public_acls"]
  block_public_policy     = var.public_access_block["block_public_policy"]
  ignore_public_acls      = var.public_access_block["ignore_public_acls"]
  restrict_public_buckets = var.public_access_block["restrict_public_buckets"]
}

resource "aws_s3_bucket_versioning" "default" {
  count  = length(var.bucket_name) != 0 ? length(var.bucket_name) : 0
  bucket = aws_s3_bucket.buckets[count.index].id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  count  = var.kms_master_key_arn != "" ? length(var.bucket_name) : 0
  bucket = aws_s3_bucket.buckets[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}