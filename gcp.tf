terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_project_service" "services" {
  for_each           = toset(var.gcp_services_list)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}