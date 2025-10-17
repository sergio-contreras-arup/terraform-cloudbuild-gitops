# Random password for database user
resource "random_password" "db_password" {
  length  = 32
  special = true
}

# Cloud SQL PostgreSQL Instance
resource "google_sql_database_instance" "postgres" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size
    disk_autoresize   = var.disk_autoresize
    user_labels       = var.labels

    backup_configuration {
      enabled                        = var.backup_enabled
      start_time                     = var.backup_start_time
      point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
      transaction_log_retention_days = var.transaction_log_retention_days
      backup_retention_settings {
        retained_backups = var.retained_backups
        retention_unit   = "COUNT"
      }
    }

    ip_configuration {
      ipv4_enabled = var.ipv4_enabled
      ssl_mode     = var.ssl_mode
      
      # Private Service Connect configuration
      psc_config {
        psc_enabled               = var.psc_enabled
        allowed_consumer_projects = var.psc_allowed_consumer_projects
      }
    }

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }

    insights_config {
      query_insights_enabled  = var.query_insights_enabled
      query_string_length     = var.query_string_length
      record_application_tags = var.record_application_tags
      record_client_address   = var.record_client_address
    }

    database_flags {
      name  = "max_connections"
      value = var.max_connections
    }

    dynamic "database_flags" {
      for_each = var.additional_database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }
  }
}

# Database
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
  project  = var.project_id
}

# Database user
resource "google_sql_user" "user" {
  name     = var.user_name
  instance = google_sql_database_instance.postgres.name
  password = var.user_password != null ? var.user_password : 'Carto-2025'
  project  = var.project_id
}

