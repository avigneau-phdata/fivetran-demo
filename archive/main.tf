terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.46.0"
    }
    fivetran = {
      source = "fivetran/fivetran"
      version = "0.6.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "fivetran" {
}

provider "snowflake" {
  account = var.snowflake_account_id
  region = "${var.snowflake_region}.aws"

  role = var.snowflake_role
  warehouse = var.snowflake_warehouse_id
}