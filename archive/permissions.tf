resource "aws_iam_policy" "fivetran_lambda_invoke" {
  name = "fivetran-lambda-invoke-autogen"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "InvokePermission",
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "*"
        },
        {
            "Sid": "AccessS3bucket",
            "Effect": "Allow",
            "Action": [
                "s3:Put*",
                "s3:Get*",
                "s3:Delete*"
            ],
            "Resource": [
                "${aws_s3_bucket.slack_user_data_bucket.arn}",
                "${aws_s3_bucket.slack_user_data_bucket.arn}/*"
            ]
        }
    ]})
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "fivetran_lambda_function_autogen"
  managed_policy_arns = [aws_iam_policy.fivetran_lambda_invoke.arn]
  assume_role_policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Principal": {
                  "AWS": "${var.fivetran_account_arn}"
              },
              "Action": "sts:AssumeRole",
              "Condition": {
                  "StringEquals": {
                      "sts:ExternalId": "${fivetran_group.group.id}"
                  }
              }
          },
          {
              "Effect": "Allow",
              "Principal": {
                  "Service": "lambda.amazonaws.com"
              },
              "Action": "sts:AssumeRole"
          }
      ]})
}