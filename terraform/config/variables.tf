variable "tf_org" {
  description = "TFE organization name"
  type        = string
}

variable "tf_host" {
  description = "Terraform Enterprise Host"
  type        = string
  default     = "infra.mavenwave.net"
}

variable "github_org" {
  description = "Github organization name"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "tenant_code" {
  description = "Tenant Label"
  type        = string
}


variable "dns_project_id" {
  description = "DNS project ID"
  type        = string
}


variable "dns_zone" {
  description = "DNS zone name"
  type        = string
}


variable "domain" {
  description = "DNS Domain"
  type        = string
}

