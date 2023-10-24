resource "aws_kms_key" "default" {
  count                   = var.kms_key.enabled && var.kms_key.id == "" ? 1 : 0
  description             = var.kms_key.description
  deletion_window_in_days = var.kms_key.deletion_window_in_days
  is_enabled              = var.kms_key.enabled
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
  multi_region            = var.kms_key.multi_region
  tags = {
    Name = "${var.instance_name}-kms-key"
  }
}

resource "aws_kms_alias" "default" {
  count         = var.kms_key.enabled && var.kms_key.id == "" ? 1 : 0
  name          = coalesce(var.kms_key.alias, "alias/${var.instance_name}")
  target_key_id = var.kms_key.id == "" ? join("", aws_kms_key.default[*].id) : var.kms_key.id
}

data "aws_iam_policy_document" "kms" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [format("arn:aws:iam::%s:root", data.aws_caller_identity.this.account_id)]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}
