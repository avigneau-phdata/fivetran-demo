output "user_login_name" {
  value = snowflake_user.fivetran_autogen_user.login_name
}

output "user_password" {
  value = snowflake_user.fivetran_autogen_user.password
}

output "db_name" {
  value = snowflake_database.fivetran_autogen_db.name
}

output "role_name" {
  value = snowflake_role.fivetran_autogen_role.name
}
