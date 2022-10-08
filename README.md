# Slack to Snowflake Fivetran Pipeline Generator

## Overview

![System architecture diagram](archecture.png)

## Required Environment Prerequisites

- Must have an AWS account user and associated access key credentials with permissions to:
    - Create and modify lambda functions
    - Create and modify IAM roles and policies
    - Create S3 buckets
    - Write to a pre-defined terraform state S3 bucket (if remote terraform state is desired)
- Must have a Snowflake account with a Snowflake user (and password) with permissions:
    - USAGE on a warehouse for executing queries
    - Granted a role that has permissions to create users/warehouses/databases
- Must have a Fivetran account and an associated API key/secret pair

## Usage

### Lambda Code
Update the `lambda_function.py` python script with the code that should be deployed to the lambda function

### Infrastructure Naming
Update the values in `main.tf` if desired to change the names of the infrastructure that will be created

### Environment Configuration
Create a file in the root directory of this repository named `.env.` and paste the following into it:

```
# These are all dummy values - replace with your own

TF_STATE_BUCKET="bucket-name"

AWS_ACCESS_KEY_ID="key-id"
AWS_SECRET_ACCESS_KEY="access-key"
AWS_REGION="us-east-1"

FIVETRAN_APIKEY="api-key"
FIVETRAN_APISECRET="secret"

SNOWFLAKE_USER="TERRAFORM_USER"
SNOWFLAKE_PASSWORD="password"
SNOWFLAKE_ACCOUNT="xxxxxx"
SNOWFLAKE_REGION="us-east-2.aws"
SNOWFLAKE_WAREHOUSE="TERRAFORM_WH"
SNOWFLAKE_ROLE="ACCOUNTADMIN"

SLACK_TOKEN="token"
```

### Execution and Deployment
Execute the `run.local.sh` script and follow the prompts to deploy the infrastructure