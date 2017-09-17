variable "access_config" {
  default     = {}
  description = " IPs via which instance can be accessed via the Internet"
  type        = "map"
}

variable "disk_image" {
  description = "The image from which to initialize the disk"
}

variable "machine_type" {
  default     = "g1-small"
  description = "The machine type to create"
}

variable "name" {
  description = "A unique name for the instance"
}

variable "network" {
  default     = "default"
  description = "The name of the network to attach instance to"
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
  description = "The zone that the instance should be created in"
}
