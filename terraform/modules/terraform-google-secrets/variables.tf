variable "secrets" {
  description = "List of Secrets to create in Secret Manager"
  type        = list(string)
}

variable "replicas" {
  description = "List of regions to replicate the secret"
  default     = ["us-central1"]
  type        = list(string)
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "secret_admins" {
  description = "Map of secret => user to assign admin privileges"
  type        = map(list(string))
  default     = {}
}

variable "admins" {
  description = "List of admin users to apply to all secrets"
  type        = list(string)
  default     = []
}

variable "secret_viewers" {
  description = "Map of secret => user to assign viewer privileges"
  type        = map(list(string))
  default     = {}
}

variable "viewers" {
  description = "List of viewer users to apply to all secrets"
  type        = list(string)
  default     = []
}