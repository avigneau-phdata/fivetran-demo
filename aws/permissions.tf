resource "aws_iam_policy" "fivetran_lambda_invoke" {
  name = var.policy_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "InvokePermission",
        "Effect" : "Allow",
        "Action" : "lambda:InvokeFunction",
        "Resource" : "*"
      }
  ] })
}

resource "aws_iam_role" "iam_for_lambda" {
  name                = var.role_name
  managed_policy_arns = [aws_iam_policy.fivetran_lambda_invoke.arn]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.fivetran_account_id}:root"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "sts:ExternalId" : "${var.fivetran_group_id}"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
  ] })
}