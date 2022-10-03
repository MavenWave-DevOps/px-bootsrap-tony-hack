module "secrets" {

  source = "../modules/terraform-google-secrets"
  secrets = [
    "argocd-github-sso-id",
    "argocd-github-sso-secret",
    "argocd-github-repo-auth",
  ]
  secret_viewers = {
    argocd-github-sso-id     = !local.disable ? [local.cluster.external_secrets_workload_identity_fqn] : []
    argocd-github-sso-secret = !local.disable ? [local.cluster.external_secrets_workload_identity_fqn] : []
    argocd-github-repo-auth  = !local.disable ? [local.cluster.external_secrets_workload_identity_fqn] : []
  }
  project_id = var.gcp_project_id
}


module "backstage_secrets" {
  source = "../modules/terraform-google-secrets"
  secrets = [
    "backstage-argocd-token",
    "backstage-jira-token",
    "backstage-github-token",
    "backstage-github-oauth-id",
    "backstage-github-oauth-secret",
    "backstage-google-oauth-id",
    "backstage-google-oauth-secret",
    "backstage-local-github-oauth-id",
    "backstage-local-github-oauth-secret",
  ]
  # secret_viewers = {
  #   backstage-argocd-token        = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-jira-token          = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-github-token        = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-github-oauth-id     = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-github-oauth-secret = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-google-oauth-id     = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  #   backstage-google-oauth-secret = !local.cluster.use_gke ? [local.cluster.external_secrets_workload_identity_fqn] : []
  # }
  project_id = var.gcp_project_id
}

