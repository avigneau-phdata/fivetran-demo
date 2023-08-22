terraform {
  backend "s3" {
    bucket = "545053092614-terraform-state"
    key    = "terraform_state-test"
    region = "us-east-1"
  }

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
