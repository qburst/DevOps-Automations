provider "aws" {
  region = var.region
}

# Lambda function code
data "archive_file" "lambda_start_function_zip" {
  type        = "zip"
  source_dir  = "./lambda-start"
  output_path = "./lambda_start_function.zip"
}

data "archive_file" "lambda_stop_function_zip" {
  type        = "zip"
  source_dir  = "./lambda-stop"
  output_path = "./lambda_stop_function.zip"
}

# Lambda execution role
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the necessary policies to your Lambda execution role
resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "lambda_execution_policy"
  policy      = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
            "Sid": "AllowLambdaExecution",
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": "arn:aws:lambda:*:*:*:*"
    },
    {
            "Sid": "AllowCloudWatchEventInvocation",
            "Effect": "Allow",
            "Action": [
                "events:PutTargets",
                "events:PutRule"
            ],
            "Resource": [
                "arn:aws:events:*:*:*"
            ]
    },        
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Start*",
        "ec2:Stop*"
      ],
      "Resource": "*"
    }
  ]
})
}

# Attaching the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

# Lambda function for starting instances
resource "aws_lambda_function" "start_ec2_instances" {
  function_name = "start-ec2-instances"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  filename      = data.archive_file.lambda_start_function_zip.output_path
  source_code_hash = data.archive_file.lambda_start_function_zip.output_base64sha256
  environment {
    variables = {
      INSTANCE_IDS = join(",", var.instance_ids)
      REGION = var.function_region
      ACTION       = "start"

    }
  }
  timeout = 60
  memory_size = 128
}

# Lambda function for stopping instances
resource "aws_lambda_function" "stop_ec2_instances" {
  function_name = "stop-ec2-instances"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  filename      = data.archive_file.lambda_stop_function_zip.output_path
  source_code_hash = data.archive_file.lambda_stop_function_zip.output_base64sha256
  environment {
    variables = {
      INSTANCE_IDS = join(",", var.instance_ids)
      REGION = var.function_region
      ACTION       = "stop"
    }
  }
  timeout = 60
  memory_size = 128
} 

# Creating cloudwatch event rule for cron
resource "aws_cloudwatch_event_rule" "lambda_start_scheduler" {
  name                = "lambda_start_scheduler"
  description         = "Schedule Lambda functions to run at 9am(IST) weekdays"
  schedule_expression = var.start_cron_value
}

resource "aws_cloudwatch_event_rule" "lambda_stop_scheduler" {
  name                = "lambda_stop_scheduler"
  description         = "Schedule Lambda functions to run at 9pm(IST) weekdays"
  schedule_expression = var.stop_cron_value
}

# Adding cloudwatch event targets
resource "aws_cloudwatch_event_target" "lambda_target_start" {
  rule      = aws_cloudwatch_event_rule.lambda_start_scheduler.name
  target_id = "start_ec2_instances"
  arn       = aws_lambda_function.start_ec2_instances.arn
}

resource "aws_cloudwatch_event_target" "lambda_target_stop" {
  rule      = aws_cloudwatch_event_rule.lambda_stop_scheduler.name
  target_id = "stop_ec2_instances"
  arn       = aws_lambda_function.stop_ec2_instances.arn
}

# providing lambda permission to invoke by cloudwatch rule
resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_ec2_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.start_ec2_instances.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.lambda_start_scheduler.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_ec2_instances" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.stop_ec2_instances.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.lambda_stop_scheduler.arn
}