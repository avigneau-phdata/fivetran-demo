resource "aws_s3_bucket" "slack_user_data_bucket" {
  bucket = "slack-user-data-autogen" 
}

resource "aws_s3_bucket_acl" "slack_user_data_bucket_acl" {
  bucket = aws_s3_bucket.slack_user_data_bucket.id
  acl    = "private"
}