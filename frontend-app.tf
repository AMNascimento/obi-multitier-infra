resource "google_cloud_run_v2_service" "obi_ui" {
  for_each = toset(var.locations_list)
  name     = "obi-ui-${each.value}"
  project  = var.project_id
  location = each.value
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "gcr.io/google-samples/zone-printer:0.2"
    }
    scaling {
      min_instance_count = 1
    }
  }
  depends_on = [google_project_service.services]
}

resource "google_compute_region_network_endpoint_group" "obi_ui_neg" {
  for_each              = toset(var.locations_list)
  name                  = "neg-${each.value}"
  region                = each.value
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_v2_service.obi_ui[each.value].name
  }
}