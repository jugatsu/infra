variable "disk_image" {
  description = "The image from which to initialize this disk"
}

variable "private_key_path" {
  description = "Path to private key used by provisioners to ssh access"
}

variable "public_key_path" {
  description = "Path to public key used for ssh access"
}

variable "username" {
  description = "The user that is used for connection"
}

variable "project" {
  description = "The ID of the project"
}

variable "region" {
  default     = "europe-west1"
  description = "The region to operate under"
}
