resource "fivetran_destination" "dest" {
    group_id            = fivetran_group.group.id
    service             = "snowflake"
    time_zone_offset    = "-5"
    region              = var.region
    trust_certificates  = "true"
    trust_fingerprints  = "true"
    run_setup_tests     = "true"

    config {
        host        = "${var.snowflake_account}.${var.snowflake_region}.aws.snowflakecomputing.com"
        port        = 443
        user        = var.snowflake_user_name
        password    = var.snowflake_password
        auth        = "password"
        database    = var.snowflake_db_name
        role        = var.snowflake_role_name
    }
}