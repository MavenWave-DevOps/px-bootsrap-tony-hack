provider "google" {}
provider "google-beta" {}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = format("https://%s", data.terraform_remote_state.cluster.outputs.cluster.primary_cluster_host)
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster.primary_cluster_ca_certificate)
}


provider "helm" {
  kubernetes {
    host  = format("https://%s", data.terraform_remote_state.cluster.outputs.cluster.primary_cluster_host)
    token = data.google_client_config.default.access_token

    # client_certificate     = file("~/.kube/client-cert.pem")
    # client_key             = file("~/.kube/client-key.pem")
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster.primary_cluster_ca_certificate)
  }
}
