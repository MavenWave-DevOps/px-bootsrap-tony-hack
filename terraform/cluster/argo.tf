
resource "google_compute_global_address" "cd_global_ip" {
  count = local.use_argocd ? 1 : 0

  project = var.gcp_project_id
  name    = local.argocd_ip_name
}


resource "google_dns_record_set" "cd_dns_record_set" {
  count = local.use_argocd ? 1 : 0

  project = var.dns_project_id

  managed_zone = var.dns_zone
  name         = "${local.argocd_domain}."
  type         = "A"
  rrdatas      = [google_compute_global_address.cd_global_ip[0].address]
  ttl          = 86400

  depends_on = [
    google_compute_global_address.cd_global_ip,
  ]
}

