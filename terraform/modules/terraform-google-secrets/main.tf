/*
* # Terraform Google Secret Manager Module
* 
* ## Description
* Create a GCP Secret and assign roles to users/service accounts.
*/

locals {
  all_admins = flatten([
    for secret in var.secrets : [
      for member in var.admins : {
        secret : secret,
        member : member
      }
    ]
  ])
  admins = flatten([
    for secret, members in var.secret_admins : [
      for member in members : {
        secret : secret,
        member : member
      }
    ]
  ])
  all_viewers = flatten([
    for secret in var.secrets : [
      for member in var.viewers : {
        secret : secret,
        member : member
      }
    ]
  ])
  viewers = flatten([
    for secret, members in var.secret_viewers : [
      for member in members : {
        secret : secret,
        member : member
      }
    ]
  ])
}

resource "google_secret_manager_secret" "main" {
  for_each  = toset(var.secrets)
  secret_id = each.key
  replication {
    user_managed {
      dynamic "replicas" {
        for_each = toset(var.replicas)
        content {
          location = replicas.key
        }
      }
    }
  }
  project = var.project_id
}

resource "google_secret_manager_secret_iam_member" "admins" {
  for_each  = { for members in concat(local.all_admins, local.admins) : "${members.secret}--${members.member}" => members }
  project   = var.project_id
  secret_id = google_secret_manager_secret.main[each.value.secret].secret_id
  role      = "roles/secretmanager.secretVersionManager"
  member    = each.value.member
}

resource "google_secret_manager_secret_iam_member" "viewers" {
  for_each  = { for members in concat(local.all_viewers, local.viewers) : "${members.secret}--${members.member}" => members }
  project   = var.project_id
  secret_id = google_secret_manager_secret.main[each.value.secret].secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value.member
}