resource "fivetran_group" "group" {
    name = "Snowflake_Autogen"
}

resource "fivetran_destination" "dest" {
    group_id = fivetran_group.group.id
    service = "snowflake"
    time_zone_offset = "-5"
    region = "AWS_US_EAST_1"
    trust_certificates = "true"
    trust_fingerprints = "true"
    run_setup_tests = "true"

    config {
        host = "${var.snowflake_account_id}.${var.snowflake_region}.aws.snowflakecomputing.com"
        port = 443
        user = snowflake_user.fivetran_autogen_user.login_name
        password = snowflake_user.fivetran_autogen_user.password
        auth = "password"
        database = snowflake_database.fivetran_autogen_db.name
        role = snowflake_role.fivetran_autogen_role.name
    }
}

resource "fivetran_connector" "lambda_connector" {
    group_id = fivetran_group.group.id
    service = "aws_lambda"
    sync_frequency = 1440
    daily_sync_time = "14:00"
    paused = false
    pause_after_trial = false
    run_setup_tests = true

    destination_schema {
        name = "aws_lambda_autogen"
    } 

    config {
        function = aws_lambda_function.slack_data_pop.function_name
        role_arn = aws_iam_role.iam_for_lambda.arn
        region = var.aws_region
        secrets = "{ \"consumerKey\": \"\", \"consumerSecret\": \"\", \"apiKey\": \"${var.slack_token}\" }"
    }
}
