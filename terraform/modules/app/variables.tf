variable "disk_image" {
  description = "The image from which to initialize the disk"
}

variable "firewall_name" {
  description = "A unique name for firewall rule"
}

variable "firewall_ports" {
  description = "List of ports and/or port ranges to allow"
  type        = "list"
}

variable "machine_type" {
  default     = "g1-small"
  description = "The machine type to create"
}

variable "name" {
  description = "A unique name for the instance"
}

variable "network" {
  description = "The name of the network to attach instance to"
  default     = "default"
}

variable "public_key_path" {
  description = "Path to public key used for ssh access"
}

variable "tags" {
  description = "A list of tags to attach to the instance"
  type        = "list"
}

variable "username" {
  description = "Username used for ssh access"
}

variable "zone" {
  default     = "europe-west1-b"
  description = "The zone that the machine should be created in"
}
