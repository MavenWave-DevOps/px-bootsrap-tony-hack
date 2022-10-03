data "google_secret_manager_secret_version" "git_creds" {
  secret  = module.secrets.secrets["argocd-github-repo-auth"].id
  project = var.gcp_project_id
}

data "google_secret_manager_secret_version" "oauth_id" {
  secret  = module.secrets.secrets["argocd-github-sso-id"].id
  project = var.gcp_project_id
}

data "google_secret_manager_secret_version" "oauth_secret" {
  secret  = module.secrets.secrets["argocd-github-sso-secret"].id
  project = var.gcp_project_id
}

resource "kubernetes_secret" "git_creds" {
  count = !local.disable ? 1 : 0

  metadata {
    name      = "github-app-creds"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }
  type = "Opaque"
  data = {
    url                 = "https://github.com/MavenWave-DevOps/"
    githubAppPrivateKey = data.google_secret_manager_secret_version.git_creds.secret_data
    # TODO: template
    githubAppID             = "229641"
    githubAppInstallationID = "28353395"
  }

  depends_on = [
    helm_release.argocd,
  ]
}


resource "kubernetes_secret" "oauth_creds" {
  count = !local.disable ? 1 : 0

  metadata {
    name      = "argocd-github-sso"
    namespace = "argocd"
    labels = {
      "app.kubernetes.io/name"    = "argocd-secret"
      "app.kubernetes.io/part-of" = "argocd"
    }
  }
  type = "Opaque"
  data = {
    "oidc.auth0.clientId"     = data.google_secret_manager_secret_version.oauth_id.secret_data
    "oidc.auth0.clientSecret" = data.google_secret_manager_secret_version.oauth_secret.secret_data
  }

  depends_on = [
    helm_release.argocd,
  ]
}


resource "helm_release" "argocd" {
  count = !local.disable ? 1 : 0

  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version          = "4.9.12"
  # version          = "5.5.5"
  create_namespace = true
  wait             = false
  reuse_values     = true

  values = [
    "${file("./values/argocd.yaml")}"
  ]

  set {
    name  = "server.config.url"
    value = "https://${local.cluster.argocd_domain}"
  }

  set {
    name  = "server.GKEmanagedCertificate.domains[0]"
    value = local.cluster.argocd_domain
  }
}
