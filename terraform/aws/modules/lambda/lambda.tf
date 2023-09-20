resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  description = var.description
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.source_code_path
  role             = aws_iam_role.lambda_execution_role.arn
  source_code_hash = filebase64sha256(var.source_code_path)
  environment {
    variables = var.environment_variables
  }
  timeout         = var.timeout
  memory_size     = var.memory_size
  tags = {
    Name = "${var.name_prefix}-lambda"
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.name_prefix}-lambda-role"
  }
}
