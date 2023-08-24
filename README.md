# Custom Source to Snowflake Pipeline Generator

## Instructions (basic deployment)
- Pull "main" repo into local environment
- Name your "test" subfolder the same name as your branch name, this is important because the deploy.yml is expecting this naming convention


## Required Environment Prerequisites

- Must have an AWS account user and associated access key credentials with permissions to:
    - Write to a pre-defined terraform state S3 bucket 545053092614-terraform-state (if remote terraform state is desired)
- Must have a Snowflake account with access to the "Fivetran_Bootcamp_Role", which will give you access to the "FIVETRAN_BOOTCAMP" database.
- Must have a Fivetran account and an associated API key/secret pair


## Usage
- Local testing:
    - For running, the code locally, you will need to open a terminal and export the following variables in your environment
        - AWS_ACCESS_KEY_ID 
        - AWS_SECRET_ACCESS_KEY
        - AWS_REGION
        - FIVETRAN_APIKEY
        - FIVETRAN_APISECRET
    - After this, run the 'terraform' commands listed in the deploy.yml
- Remote testing:
    - Once all code is ready, commit changes and push remote branch.  Note: If you have already tested the code locally, you'll need to remove the lambda function in AWS as a new terraform state file will be created and it will error when it detects the existing lambda.


### Lambda Code
- Out of the box, the provided lambda code will run and create some sample records in the target Snowflake schema you declare.  You can also update the code in the location [aws/lambda](./aws/lambda/) if you want to query API data and pass it back to Fivetran.

### Infrastructure Naming
- Update the following values in [main.tf](./main.tf) file.  This will be to store your state file when you push your code and Github Actions runs your pipeline:
    - backend "s3" 
        - key  = [name of the branch you create]

- Update the following variables in the [test.tfvars](./test.tfvars) file:
    - lambda_function_name         = [name of your lambda function that will show up in AWS lambda page]
    - snowflake_destination_schema = [name of the snowflake schema you are writing to]

