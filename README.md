# Slack to Snowflake Fivetran Pipeline Generator

## Overview

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
