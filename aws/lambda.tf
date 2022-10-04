resource "aws_lambda_function" "lambda_function" {
  filename          = var.lambda_package
  function_name     = var.lambda_function_name
  role              = aws_iam_role.iam_for_lambda.arn
  handler           = var.lambda_handler

  source_code_hash  = filebase64sha256(var.lambda_package)

  runtime           = var.lambda_runtime
}