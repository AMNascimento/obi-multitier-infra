variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "northamerica-northeast1"
}

variable "locations_list" {
  type        = list(string)
  description = "List of locations to deploy app"
  default = [
    "northamerica-northeast1",
    "us-east1"
  ]
}

variable "zone" {
  type    = string
  default = "northamerica-northeast1-b"
}

variable "credentials_file" {
  type = string
}

variable "gcp_services_list" {
  type        = list(string)
  description = "List of required GCP APIs"
  default = [
    "compute.googleapis.com",
    "cloudapis.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "spanner.googleapis.com"
  ]
}