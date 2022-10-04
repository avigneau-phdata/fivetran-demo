resource "aws_lambda_function" "slack_data_pop" {
  filename      = "code.zip"
  function_name = "slack_data_autogen"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("code.zip")

  runtime = "python3.9"
}