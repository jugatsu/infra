variable "account_id" {
  description = "The service account ID"
}

variable "display_name" {
  description = "The display name for the service account"
}

// Ensure that gcloud is within $PATH or provide full path to executable
variable "gcloud" {
  description = "Google's gcloud cli executable"
  default     = "gcloud"
}

variable "key_path" {
  description = "Path to created key file for service account"
}

variable "project" {
  description = "The project ID"
}

variable "role" {
  description = "The role that should be applied"
}
