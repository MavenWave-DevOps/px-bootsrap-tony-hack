
locals {
  cluster = data.terraform_remote_state.cluster.outputs

  disable = !local.cluster.use_gke || false

  gcp_provider_iam = !local.disable ? setsubtract([
    local.cluster.crossplane_gcp_provider_workload_identity_fqn,
    local.cluster.cnrm_workload_identity_fqn,
  ], [null]) : []

  image_viewers = !local.disable ? setsubtract([
    local.cluster.argocd_workload_identity_fqn,
  ], [null]) : []

  secret_viewers = !local.disable ? setsubtract([
    local.cluster.external_secrets_workload_identity_fqn,
  ], [null]) : []

  dns_admins = !local.disable ? setsubtract([
    local.cluster.external_dns_workload_identity_fqn,
  ], [null]) : []

  image_updater = !local.disable ? setsubtract([
    local.cluster.argocd_workload_identity_fqn,
  ], [null]) : []
}
