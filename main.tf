terraform {

}

module "aws" {
    source = "./aws"

    region = var.aws_region
    
    policy_name = "fivetran-lambda-invoke-autogen"
    role_name = "fivetran_lambda_function_autogen"
    bucket_name = "slack-user-data-autogen"
    lambda_function_name = "slack_data_autogen"
    lambda_handler = "lambda_function.lambda_handler"
    lambda_runtime = "python3.9"
    lambda_package = "code.zip"
    fivetran_account_id = "834469178297"

    fivetran_group_id = module.fivetran.group_id
}

module "fivetran" {
    source = "./fivetran"
    
    group_name = "Snowflake_Autogen"
    snowflake_destination_schema = "aws_lambda_autogen"
    region = "US"

    snowflake_account = var.snowflake_account_id
    snowflake_region = var.snowflake_region
    snowflake_db_name = module.snowflake.db_name
    snowflake_role_name = module.snowflake.role_name
    snowflake_user_name = module.snowflake.user_login_name
    snowflake_password = module.snowflake.user_password

    lambda_function_name = module.aws.lambda_function_name
    lambda_role_arn = module.aws.role_arn
    lambda_aws_region = var.aws_region

    secrets = "{ \"consumerKey\": \"\", \"consumerSecret\": \"\", \"apiKey\": \"${var.slack_token}\" }"
}

module "snowflake" {
    source = "./snowflake"

    region = var.snowflake_region
    account_id = var.snowflake_account_id
    admin_role = var.snowflake_role
    admin_warehouse_id = var.snowflake_warehouse_id

    db_name = "FIVETRAN_AUTOGEN"
    db_privileges = [ "USAGE", "MODIFY", "CREATE SCHEMA" ]
    warehouse_name = "FIVETRAN_AUTOGEN_WH"
    warehouse_size = "XSMALL"
    user_name = "FIVETRAN_AUTOGEN_USER"
    role_name = "FIVETRAN_AUTOGEN_ROLE"
}
