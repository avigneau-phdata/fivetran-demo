resource "fivetran_connector" "lambda_connector" {
  group_id          = var.group_id
  service           = "aws_lambda"
  sync_frequency    = 1440
  daily_sync_time   = "14:00"
  paused            = true
  pause_after_trial = true
  run_setup_tests   = true

  destination_schema {
    name = var.username
  }

  config {
    function = aws_lambda_function.lambda_function.function_name
    role_arn = var.bootcamp_role_arn
    region   = "us-east-1"
  }
}

resource "aws_lambda_function" "lambda_function" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.username
  role          = var.bootcamp_role_arn
  handler       = var.entry_point_ref

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime = var.lambda_runtime
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/tmp/lambda.zip"
  source_dir  = "${path.module}/${var.lambda_code_folder}/"
}
