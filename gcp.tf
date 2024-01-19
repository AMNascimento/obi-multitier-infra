terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("./.terraform/obi-test-411621-7cae06df0c1d.json")
  project     = local.project_id
  region      = "us-east1"
  zone        = "us-east1-b"
}