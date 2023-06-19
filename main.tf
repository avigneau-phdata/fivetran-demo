terraform {
  #backend "s3" {
  #  key    = "slack-fivetran"
  #}
}

module "aws" {
  source = "./aws"

  policy_name          = "fivetran-lambda-invoke-autogen"
  role_name            = "fivetran_lambda_function_autogen"
  bucket_name          = "slack-user-data-autogen"
  lambda_function_name = "stock_candles_lambda"
  lambda_runtime       = "python3.9"
  fivetran_account_id  = "834469178297"

  fivetran_group_id = module.fivetran.group_id
}

module "fivetran" {
  source = "./fivetran"

  group_name                   = "Demo_Snowflake"
  snowflake_destination_schema = "stocks"
  region                       = "US"

  snowflake_host      = "lf41672.us-east-2.aws.snowflakecomputing.com"
  snowflake_db_name   = "FIVETRAN_DB"
  snowflake_role_name = "FIVETRAN_ROLE"
  snowflake_user_name = "FIVETRAN_USER"
  snowflake_password  = var.snowflake_password

  lambda_function_name = module.aws.lambda_function_name
  lambda_role_arn      = module.aws.role_arn
  lambda_aws_region    = module.aws.region

  secrets = "{ \"apiKey\": \"${var.finnhub_api_key}\" }"
}
