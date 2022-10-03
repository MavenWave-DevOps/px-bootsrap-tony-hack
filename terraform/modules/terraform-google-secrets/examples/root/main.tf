module "project" {
  source            = "terraform-google-modules/project-factory/google"
  version           = "11.2.3"
  name              = "secrets-manager-terratest"
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_account
  folder_id         = var.folder_id
  activate_apis = [
    "secretmanager.googleapis.com"
  ]
}

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "4.0.3"
  prefix     = "secrets"
  names      = ["admin", "viewer", "foo", "bar"]
  project_id = module.project.project_id
}

module "secrets" {
  source = "../../"
  secrets = [
    "foo",
    "bar"
  ]
  admins = [module.service_accounts.iam_emails["admin"]]
  secret_admins = {
    foo = [module.service_accounts.iam_emails["foo"]]
    bar = [module.service_accounts.iam_emails["bar"]]
  }
  viewers = [module.service_accounts.iam_emails["viewer"]]
  secret_viewers = {
    foo = [module.service_accounts.iam_emails["bar"]]
    bar = [module.service_accounts.iam_emails["foo"]]
  }
  project_id = module.project.project_id
}