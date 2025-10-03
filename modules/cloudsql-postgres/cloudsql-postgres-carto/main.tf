resource "google_sql_database_instance" "postgres_carto" {
  name                = var.instance_name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size

    backup_configuration {
      enabled = var.backup_enabled
    }

    ip_configuration {
      ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.cidr
        }
      }
    }
  }

  depends_on = [google_project_service.sqladmin]
}

resource "google_sql_database" "app_db_carto" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres_carto.name
}

resource "random_password" "app_user_pwd_carto" {
  length  = 20
  special = true
}

resource "google_sql_user" "app_user_carto" {
  name     = var.user_name
  instance = google_sql_database_instance.postgres_carto.name
  password = random_password.app_user_pwd_carto.result
}


