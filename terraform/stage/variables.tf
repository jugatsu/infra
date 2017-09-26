#################################
# Google Cloud Provider variables
#################################

variable "google_project" {
  description = "The ID of the project"
}

variable "google_region" {
  default     = "europe-west1"
  description = "The region to operate under"
}

variable "google_version" {
  default     = "~> 0.1"
  description = "The version of provider module"
}

#################################
# Github Provider variables
#################################

variable "github_token" {}
variable "github_organization" {}

#################################
# App variables
#################################

variable "app_disk_image" {
  description = "The image from which to initialize the disk for front-end"
}

variable "app_firewall_name" {
  description = "A unique name for firewall rule to access front-end"
}

variable "app_firewall_ports" {
  description = "List of ports and/or port ranges to allow"
  type        = "list"
}

variable "app_name" {
  description = "A unique name for the front-end instance"
}

variable "app_public_key_path" {
  description = "Path to public key used for ssh access to front-end"
}

variable "app_tags" {
  description = "A list of tags to attach to the front-end"
  type        = "list"
}

variable "app_username" {
  description = "Username used for ssh access to front-end"
}

#################################
# DB variables
#################################

variable "db_disk_image" {
  description = "The image from which to initialize the disk for database"
}

variable "db_firewall_name" {
  description = "A unique name for firewall rule to access database"
}

variable "db_firewall_ports" {
  description = "List of ports and/or port ranges to allow to access database"
  type        = "list"
}

variable "db_name" {
  description = "A unique name for the database instance"
}

variable "db_public_key_path" {
  description = "Path to public key used for ssh access to database"
}

variable "db_source_tags" {
  description = "A list of source tags for firewall rule to attach to database"
  type        = "list"
}

variable "db_tags" {
  description = "A list of tags to attach to the database"
  type        = "list"
}

variable "db_username" {
  description = "Username used for ssh access to database"
}
