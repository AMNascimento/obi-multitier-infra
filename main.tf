# resource "google_compute_network" "vpc_network" {
#   name                            = "obi-network"
#   auto_create_subnetworks         = false
#   delete_default_routes_on_create = true
#   depends_on                      = [google_project_service.compute_service]
# }

# resource "google_compute_subnetwork" "obi_subnet" {
#   name          = "obi-subnet"
#   ip_cidr_range = "10.2.0.0/16"
#   network       = google_compute_network.vpc_network.self_link
# }

# resource "google_compute_route" "obi_network_internet_route" {
#   name             = "obi-network-internet"
#   dest_range       = "0.0.0.0/0"
#   network          = google_compute_network.vpc_network.self_link
#   next_hop_gateway = "default-internet-gateway"
#   priority         = 100
# }

# resource "google_compute_router" "router" {
#   name    = "obi-router"
#   network = google_compute_network.vpc_network.self_link
# }

# resource "google_compute_router_nat" "nat" {
#   name                               = "obi-router-nat"
#   router                             = google_compute_router.router.name
#   region                             = google_compute_router.router.region
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
# }

# Module documentation -> https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/latest?utm_content=workspace/executeCommand/module.calls&utm_medium=Visual+Studio+Code&utm_source=terraform-ls
module "lb-http" {
  source                          = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version                         = "~> 9.0"
  project                         = var.project_id
  name                            = "external-load-balancer"
  managed_ssl_certificate_domains = ["obi.com"]
  ssl                             = true
  https_redirect                  = true

  backends = {
    default = {
      groups = [
        for neg in google_compute_region_network_endpoint_group.obi_ui_neg :
        {
          group = neg.id
        }
      ]

      enable_cdn = false
      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
  depends_on = [google_project_service.services]
}

resource "google_service_account" "obi_app_sa" {
  project                      = var.project_id
  account_id                   = "obi-app-sa"
  display_name                 = "Obi App Service Account"
  create_ignore_already_exists = true
}

resource "google_project_iam_member" "obi_app_sa" {
  project    = var.project_id
  role       = "roles/secretmanager.secretAccessor"
  member     = google_service_account.obi_app_sa.email
  depends_on = [google_project_service.services]
}