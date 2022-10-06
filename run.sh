#!/bin/bash

export AWS_ACCESS_KEY_ID="<access_key_id>"
export AWS_SECRET_ACCESS_KEY="<access_key>"
export AWS_REGION="us-east-1"

export FIVETRAN_APIKEY="<api_key>"
export FIVETRAN_APISECRET="<api_secret>"

export SNOWFLAKE_USER="<cicd_user>"
export SNOWFLAKE_PASSWORD="<cicd_user_password>"

export TF_VAR_slack_token="<slack_token>"

zip code.zip lambda_function.py

terraform init

while true; do
    read -p "Do you wish to run the planning phase? " yn
    case $yn in
        [Yy]* ) terraform plan -out=tfplan; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to run the apply phase? " yn
    case $yn in
        [Yy]* ) terraform apply tfplan; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

rm -f code.zip
