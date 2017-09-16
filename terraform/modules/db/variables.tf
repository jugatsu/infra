variable "disk_image" {}

variable "firewall_name" {}

variable "firewall_ports" {
  type = "list"
}

variable "machine_type" {
  default = "g1-small"
}

variable "name" {}

variable "network" {
  description = ""
  default     = "default"
}

variable "public_key_path" {
  description = "Path to public key used for ssh access"
}

variable "source_tags" {
  type = "list"
}

variable "tags" {
  type = "list"
}

variable "username" {}

variable "zone" {
  default = "europe-west1-b"
}
