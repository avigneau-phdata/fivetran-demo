region                       = "AWS_US_EAST_1"
group_id                     = "permitted_chuck"
bootcamp_role_arn            = "arn:aws:iam::545053092614:role/iam_for_lambda"
entry_point_ref              = "example_function.lambda_handler"
lambda_function_name         = [insert function name]
lambda_runtime               = "python3.9"
lambda_code_folder           = "lambda"
snowflake_destination_schema = [insert schema name]
