output "lambda_function_name" {
  description = "The name of the created Lambda function"
  value       = aws_lambda_function.lambda.function_name
}
