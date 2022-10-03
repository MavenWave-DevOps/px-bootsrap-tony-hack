
module "crossplane_gcp_iam" {
  source = "terraform-google-modules/iam/google//modules/projects_iam"

  projects = [var.gcp_project_id]
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = local.image_updater,
    "roles/iam.serviceAccountUser"         = local.gcp_provider_iam,
    "roles/cloudbuild.builds.editor"       = local.gcp_provider_iam,
    "roles/cloudkms.admin"                 = local.gcp_provider_iam,
    "roles/compute.admin"                  = local.gcp_provider_iam,
    "roles/storage.admin"                  = local.gcp_provider_iam,
    "roles/container.admin"                = local.gcp_provider_iam,
    "roles/artifactregistry.admin"         = local.gcp_provider_iam,
    "roles/secretmanager.secretAccessor"   = local.secret_viewers,
    "roles/storage.objectViewer"           = local.image_viewers,
    "roles/iap.httpsResourceAccessor"      = [
      "group:devops@mavenwave.com",
      "group:infra@mavenwave.com"
    ]
  }
}

module "dns_iam" {
  source = "terraform-google-modules/iam/google//modules/projects_iam"

  projects = [var.dns_project_id]
  bindings = {
    "roles/dns.admin" = local.dns_admins,
  }
}

