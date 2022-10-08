#!/bin/bash

export $(grep -v '^#' .env | xargs)

export TF_VAR_slack_token=$SLACK_TOKEN

zip code.zip lambda_function.py

while true; do
    read -p "Do you wish to init with remote state configuration? " yn
    case $yn in
        [Yy]* ) terraform init \
                    -backend-config="bucket=${TF_STATE_BUCKET}" \
                    -backend-config="key=slack-fivetran" \
                    -backend-config="region=${AWS_REGION}"

            break;;

        [Nn]* ) terraform init; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to run the planning phase? " yn
    case $yn in
        [Yy]* ) terraform plan -out=tfplan 

            while true; do
                read -p "Do you wish to run the apply phase? " yn
                case $yn in
                    [Yy]* ) terraform apply tfplan; break;;
                    [Nn]* ) break;;
                    * ) echo "Please answer yes or no.";;
                esac
            done
            
            break;;

        [Nn]* ) break;;

        * ) echo "Please answer yes or no.";;
    esac
done

rm -f code.zip
