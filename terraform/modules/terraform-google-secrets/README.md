<!-- BEGIN_TF_DOCS -->
# Terraform Google Secret Manager Module

## Description
Create a GCP Secret and assign roles to users/service accounts.

## Example
```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.67.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.67.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 3.67.0 |

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |
| [google_secret_manager_secret_iam_member.viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admins"></a> [admins](#input\_admins) | List of admin users to apply to all secrets | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | List of regions to replicate the secret | `list(string)` | <pre>[<br>  "us-central1"<br>]</pre> | no |
| <a name="input_secret_admins"></a> [secret\_admins](#input\_secret\_admins) | Map of secret => user to assign admin privileges | `map(list(string))` | `{}` | no |
| <a name="input_secret_viewers"></a> [secret\_viewers](#input\_secret\_viewers) | Map of secret => user to assign viewer privileges | `map(list(string))` | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of Secrets to create in Secret Manager | `list(string)` | n/a | yes |
| <a name="input_viewers"></a> [viewers](#input\_viewers) | List of viewer users to apply to all secrets | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_list"></a> [secret\_list](#output\_secret\_list) | List of GCP Secret Manager secrets |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Map of GCP Secret Manager secrets |

<!-- END_TF_DOCS -->