terraform {
  required_providers {
    fivetran = {
      source  = "fivetran/fivetran"
      version = "0.6.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
