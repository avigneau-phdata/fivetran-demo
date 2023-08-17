region = "us-east-1"
group_id = "permitted_chuck"
bootcamp_role_arn = "arn:aws:iam::545053092614:role/iam_for_lambda"

entry_point_ref = "module.method"
lambda_function_name = "stock_candles_test"
lambda_runtime = "python"
lambda_code_folder = "lambda"
snowflake_destination_schema = "stocks_av_test"