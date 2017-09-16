variable "disk_image" {}

variable "machine_type" {
  default = "g1-small"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "public_key_path" {
  description = "Path to public key used for ssh access"
}

variable "tags" {
  type = "list"
}

variable "name" {}

variable "network" {
  description = ""
  default     = "default"
}

variable "username" {}

variable "firewall_name" {}

variable "firewall_ports" {
  type = "list"
}
