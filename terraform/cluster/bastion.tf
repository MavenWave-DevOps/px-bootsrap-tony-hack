
resource "google_compute_instance" "bastion" {
  count = local.use_bastion ? 1 : 0

  project                   = var.gcp_project_id
  name                      = "bastion"
  machine_type              = "e2-standard-2"
  zone                      = "us-central1-a"
  can_ip_forward            = false
  tags                      = ["bastion"]
  allow_stopping_for_update = true

  boot_disk {
    device_name = "bastion"
    auto_delete = true
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  network_interface {
    network            = var.network_name
    subnetwork         = local.subnet_name
    subnetwork_project = var.gcp_project_id
  }

  depends_on = [
    module.vpc,
    module.subnets,
    module.gke,
  ]
}

##################
## Run asmcl #####
##################

# resource "null_resource" "asm_install" {
#
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#
#   provisioner "local-exec" {
#     command = "/bin/bash ./bin/asm.sh --cluster-name ${local.cluster_name} --dir-path /tmp --jumpbox-name ${google_compute_instance.bastion.name} --cluster-location ${local.region} --project-id ${var.gcp_project_id}  --user ${var.service_account}"
#   }
#
#   depends_on = [
#     google_compute_instance.bastion,
#   ]
# }
#
#
#
