# resource "google_sql_database_instance" "my_sql_db" {
#   name             = "obi-db"
#   database_version = "MYSQL_5_7"
#   region           = var.region
#   project          = var.project_id
#   settings {
#     tier                  = "db-g1-small"
#     disk_autoresize       = true
#     disk_autoresize_limit = 0
#     disk_size             = 10
#     disk_type             = "PD_SSD"
#     ip_configuration {
#       ipv4_enabled    = false
#       private_network = google_compute_subnetwork.obi_subnet.id
#     }
#     location_preference {
#       zone = var.zone
#     }
#   }
#   deletion_protection = false
#   depends_on          = []
# }


resource "google_spanner_instance" "obi_spanner" {
  name         = "obi-spanner"
  display_name = "Multi Regional DB"
  config       = "nam14"
  project      = var.project_id
  autoscaling_config {
    autoscaling_limits {
      max_processing_units = 2000
      min_processing_units = 500
    }
    autoscaling_targets {
      high_priority_cpu_utilization_percent = 75
      storage_utilization_percent           = 90
    }
  }
}

resource "google_spanner_database" "obi_db" {
  instance                 = google_spanner_instance.obi_spanner.name
  name                     = "obi-db"
  project                  = var.project_id
  version_retention_period = "3d"
  ddl                      = []
  deletion_protection      = true
}