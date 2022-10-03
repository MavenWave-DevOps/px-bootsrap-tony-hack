module "external_dns_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "external-dns"
  namespace           = "external-dns"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "external_secrets_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "external-secrets"
  namespace           = "external-secrets"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "argocd_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "argocd"
  k8s_sa_name         = "argocd-secrets"
  namespace           = "argocd"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "backstage_secrets_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "backstage-secrets"
  k8s_sa_name         = "backstage-secrets-sa"
  namespace           = "backstage"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "backstage_app_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "backstage-app"
  k8s_sa_name         = "backstage-sa"
  namespace           = "backstage"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "cnrm_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "infra-admin"
  k8s_sa_name         = "cnrm-controller-manager"
  namespace           = "cnrm-system"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "crossplane_gcp_provider_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "crossplane-gcp"
  k8s_sa_name         = "gcp-provider"
  namespace           = "crossplane-system"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}

module "crossplane_kubernetes_provider_workload_identity" {
  count = var.use_gke ? 1 : 0

  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version             = "21.0.0"
  use_existing_gcp_sa = false
  use_existing_k8s_sa = true
  annotate_k8s_sa     = false
  name                = "crossplane-kubernetes"
  k8s_sa_name         = "kubernetes-provider"
  namespace           = "crossplane-system"
  project_id          = var.gcp_project_id
  cluster_name        = module.gke.primary_cluster_name

  depends_on = [module.gke]
}
