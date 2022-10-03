output "use_gke" {
  value = var.use_gke
}

output "cluster" {
  value     = var.use_gke ? module.gke : null
  sensitive = true
}

output "argocd_workload_identity_fqn" {
  value = var.use_gke ? module.argocd_workload_identity[0].gcp_service_account_fqn : null
}

output "backstage_workload_identity_fqn" {
  value = var.use_gke ? module.backstage_secrets_workload_identity[0].gcp_service_account_fqn : null
}

output "crossplane_gcp_provider_workload_identity_fqn" {
  value = var.use_gke ? module.crossplane_gcp_provider_workload_identity[0].gcp_service_account_fqn : null
}

output "cnrm_workload_identity_fqn" {
  value = var.use_gke ? module.cnrm_workload_identity[0].gcp_service_account_fqn : null
}

output "external_dns_workload_identity_fqn" {
  value = var.use_gke ? module.external_dns_workload_identity[0].gcp_service_account_fqn : null
}

output "external_secrets_workload_identity_fqn" {
  value = var.use_gke ? module.external_secrets_workload_identity[0].gcp_service_account_fqn : null
}

output "external_secrets_workload_identity_email" {
  value = var.use_gke ? module.external_secrets_workload_identity[0].gcp_service_account_email : null
}

output "argocd_domain" {
  value = local.argocd_domain
}

output "argocd_ip_name" {
  value = local.argocd_ip_name
}

output "test" {
  value = "test-output"
}
