#################################
# Google Cloud Provider variables
#################################

variable "project" {
  description = "The ID of the project"
}

variable "region" {
  default     = "europe-west1"
  description = "The region to operate under"
}

#################################
# App variables
#################################

variable "app_disk_image" {
  description = ""
}

variable "app_firewall_name" {}

variable "app_firewall_ports" {
  type = "list"
}

variable "app_name" {}

variable "app_public_key_path" {
  description = ""
}

variable "app_tags" {
  type = "list"
}

variable "app_username" {}

#################################
# DB variables
#################################

variable "db_disk_image" {
  description = ""
}

variable "db_firewall_name" {}

variable "db_firewall_ports" {
  type = "list"
}

variable "db_name" {}

variable "db_public_key_path" {
  description = ""
}

variable "db_source_tags" {
  type = "list"
}

variable "db_tags" {
  type = "list"
}

variable "db_username" {}
