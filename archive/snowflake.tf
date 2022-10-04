resource snowflake_user fivetran_autogen_user {
  name         = "FIVETRAN_AUTOGEN_USER"
  password     = random_password.password.result
  disabled     = false

  default_warehouse = snowflake_warehouse.fivetran_autogen_wh.name
  default_role      = snowflake_role.fivetran_autogen_role.name

  must_change_password = false
}

resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "!#%"
}

resource snowflake_role fivetran_autogen_role {
  name    = "FIVETRAN_AUTOGEN_ROLE"
}

resource "snowflake_database" "fivetran_autogen_db" {
  name                        = "FIVETRAN_AUTOGEN"
  data_retention_time_in_days = 0
}

resource snowflake_warehouse fivetran_autogen_wh {
  name           = "FIVETRAN_AUTOGEN_WH"
  warehouse_size = "XSMALL"
}

resource snowflake_role_grants role_grant {
  role_name = snowflake_role.fivetran_autogen_role.name

  users = [
    "${snowflake_user.fivetran_autogen_user.name}"
  ]
}

resource snowflake_database_grant db_grant_create {
  database_name = snowflake_database.fivetran_autogen_db.name

  privilege = "CREATE SCHEMA"
  roles     = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}

resource snowflake_database_grant db_grant_modify {
  database_name = snowflake_database.fivetran_autogen_db.name

  privilege = "MODIFY"
  roles     = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}

resource snowflake_database_grant db_grant_usage {
  database_name = snowflake_database.fivetran_autogen_db.name

  privilege = "USAGE"
  roles     = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}

resource snowflake_warehouse_grant wh_grant {
  warehouse_name = snowflake_warehouse.fivetran_autogen_wh.name
  privilege      = "USAGE"

  roles = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}
