# AWS Lambda function

resource "aws_lambda_function" "task_processor" {

  function_name = "week36-serverless-task-processor"

  role = aws_iam_role.lambda_execution.arn

  runtime = "python3.12"

  handler = "lambda_app.lambda_handler"

  filename = "${path.module}/../deployment.zip"

  source_code_hash = filebase64sha256(
    "${path.module}/../deployment.zip"
  )

  timeout     = 10
  memory_size = 128

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]

  tags = {
    Name        = "Week36-Serverless-Task-Processor"
    Project     = "Week36"
    Environment = "Learning"
  }
}
