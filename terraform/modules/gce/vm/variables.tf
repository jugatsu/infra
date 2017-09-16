variable "access_config" {
  default = {}
  type    = "map"
}

variable "disk_image" {}

variable "machine_type" {
  default = "g1-small"
}

variable "name" {}

variable "network" {
  default = "default"
}

variable "public_key_path" {
  description = "Path to public key used for ssh access"
}

variable "tags" {
  type = "list"
}

variable "username" {}

variable "zone" {
  default = "europe-west1-b"
}
