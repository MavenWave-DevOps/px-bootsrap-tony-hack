
module "vpc" {
  source                                 = "terraform-google-modules/network/google//modules/vpc"
  project_id                             = var.gcp_project_id
  network_name                           = var.network_name
  routing_mode                           = var.routing_mode
  shared_vpc_host                        = var.shared_vpc_host
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
}
