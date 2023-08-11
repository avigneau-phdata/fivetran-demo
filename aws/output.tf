output "lambda_function_name" {
  value = aws_lambda_function.lambda_function.function_name
}

output "role_arn" {
  value = "arn:aws:iam::545053092614:role/iam_for_lambda"
}

output "region" {
  value = data.aws_region.region.name
}
