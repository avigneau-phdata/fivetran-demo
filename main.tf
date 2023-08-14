
module "aws" {
  source = "./aws"

# fill in the lambda_function_name here:

  lambda_function_name = "stock_candles_lambda_av"
  lambda_runtime       = "python3.9"

  fivetran_group_id = module.fivetran.group_id
}

module "fivetran" {
  source = "./fivetran"

# fill in the name of your snowflake_destination_schema here:

  group_name                   = "permitted_chuck"
  snowflake_destination_schema = "stocks_av" 
  region                       = "US"

  snowflake_host      = "lga76011.us-east-1.snowflakecomputing.com"
  snowflake_db_name   = "FIVETRAN_BOOTCAMP"
  snowflake_role_name = "FIVETRAN_BOOTCAMP_ROLE"
  snowflake_user_name = "FIVETRAN_BOOTCAMP_USER"
  snowflake_password  = ""

  lambda_function_name = module.aws.lambda_function_name
  lambda_role_arn      = module.aws.role_arn
  lambda_aws_region    = module.aws.region

  secrets = "{ \"apiKey\": \"cjajaehr01qji1gtm9egcjajaehr01qji1gtm9f0\" }"
}
