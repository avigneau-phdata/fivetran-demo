terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.46.0"
    }
  }
}

provider "snowflake" {
  account = var.account_id
  region = "${var.region}.aws"

  role = var.admin_role
  warehouse = var.admin_warehouse_id
}
