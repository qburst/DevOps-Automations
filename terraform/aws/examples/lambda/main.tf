module "my_lambda" {
  source            = "../../modules/lambda"
  description = "Delete default VPCs"
  name_prefix       = "qburst"
  function_name     = "MyLambdaFunction"
  handler           = "lambda1.lambda_handler"
  runtime           = "python3.11"
  source_code_path  = "./lambda_zip/lambda1.zip"
  environment_variables = {
    MY_ENV_VAR = "some-value"
  }
  timeout           = 60
  memory_size       = 256
   policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::691936972587:policy/service-role/AWSLambdaBasicExecutionRole-a61b5924-9719-48a9-8b48-d5a12a46fa1e"
  ]
}
