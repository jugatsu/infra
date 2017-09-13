variable "app_disk_image" {
  description = "The image from which to initialize this disk"
}

variable "app_private_key_path" {
  default     = "~/.ssh/appuser"
  description = "Path to private key used by provisioners to ssh access"
}

variable "app_public_key_path" {
  default     = "~/.ssh/appuser.pub"
  description = "Path to public key used for ssh access"
}

variable "app_username" {
  default     = "appuser"
  description = "The user that is used for connection"
}

variable "project" {
  description = "The ID of the project"
}

variable "region" {
  default     = "europe-west1"
  description = "The region to operate under"
}
