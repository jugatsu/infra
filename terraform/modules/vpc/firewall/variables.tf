variable "description" {
  default     = ""
  description = "Textual description of firewall rule"
}

variable "name" {
  description = "A unique name for the firewall rule"
}

variable "network" {
  default     = "default"
  description = "The name of the network to attach instance to"
}

variable "ports" {
  description = "List of ports and/or port ranges to allow"
  type        = "list"
}

variable "protocol" {
  description = "The name of the protocol to allow"
  default     = "tcp"
}

variable "source_ranges" {
  description = "A list of source CIDR ranges that firewall rule applies to"
  default     = ["0.0.0.0/0"]
  type        = "list"
}

variable "source_tags" {
  description = "A list of source tags for firewall rule"
  default     = []
  type        = "list"
}

variable "target_tags" {
  description = "A list of target tags for firewall rule"
  default     = []
  type        = "list"
}
