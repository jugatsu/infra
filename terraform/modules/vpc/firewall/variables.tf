variable "description" {
  default = ""
}

variable "name" {}

variable "network" {
  default = "default"
}

variable "ports" {
  description = ""
  type        = "list"
}

variable "protocol" {
  description = ""
  default     = "tcp"
}

variable "source_ranges" {
  description = ""

  default = [
    "0.0.0.0/0",
  ]

  type = "list"
}

variable "source_tags" {
  description = ""
  default     = []
  type        = "list"
}

variable "target_tags" {
  description = ""
  default = []
  type        = "list"
}
