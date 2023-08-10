/*
terraform {
  backend "s3" {}
}

*/
module "aws" {
  source = "./aws"

  policy_name          = "fivetran-lambda-invoke"
  role_name            = "fivetran_lambda_function"
  lambda_function_name = "stock_candles_lambda"
  lambda_runtime       = "python3.9"
  fivetran_account_id  = "834469178297"

  fivetran_group_id = module.fivetran.group_id
}

module "fivetran" {
  source = "./fivetran"

  group_name                   = "Fivetran_Bootcamp"
  snowflake_destination_schema = "stocks"
  region                       = "US"

  snowflake_host      = "lga76011.us-east-1.snowflakecomputing.com"
  snowflake_db_name   = "FIVETRAN_BOOTCAMP"
  snowflake_role_name = "FIVETRAN_BOOTCAMP_ROLE"
  snowflake_user_name = "FIVETRAN_BOOTCAMP_USER"
  snowflake_password  = ""

  lambda_function_name = module.aws.lambda_function_name
  lambda_role_arn      = module.aws.role_arn
  lambda_aws_region    = module.aws.region

  secrets = "{ \"apiKey\": \"${var.finnhub_api_key}\" }"
}
