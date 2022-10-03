
output "primary_cluster_name" {
  description = "GKE cluster name"
  value       = var.use_gke ? module.gke[0].name : ""
}

output "primary_cluster_host" {
  description = "GKE cluster host"
  value       = var.use_gke ? module.gke[0].endpoint : ""
}

output "primary_cluster_ca_certificate" {
  description = "GKE cluster host"
  value       = var.use_gke ? module.gke[0].ca_certificate : ""
}

# output "failover_cluster_name" {
#   description = "GKE failover cluster name"
#   value       = var.use_failover ? module.failover_gke[0].name
# }
