resource "google_cloud_run_v2_service" "obi_app" {
  for_each = toset(var.locations_list)
  name     = "obi-app-${each.value}"
  project  = var.project_id
  location = each.value
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    containers {
      image = "gcr.io/cloudrun/hello"
    }
    scaling {
      min_instance_count = 1
    }
  }
  depends_on = [google_project_service.services]
}