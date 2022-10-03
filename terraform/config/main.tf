data "terraform_remote_state" "cluster" {
  backend = "remote"
  config = {
    hostname     = var.tf_host
    organization = var.tf_org
    workspaces = {
      name = "px-${var.tenant_code}-cluster"
    }
  }
}
