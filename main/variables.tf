variable "group_id" {
  type = string
}

variable "region" {
  type = string

  validation {
    condition     = contains(["AWS_US_EAST_1", "US"], var.region)
    error_message = "Allowed values for fivetran_region are \"AWS_US_EAST_1\"."
  }
}

variable "bootcamp_role_arn" {
  type = string
}

variable "entry_point_ref" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_code_folder" {
  type = string
}

variable "username" {
  type = string
}
