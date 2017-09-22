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

#################################
# Service accounts
#################################

# service account for ansible dynamic inventory
variable "ansible_service_account_account_id" {
  description = "The ansble service account ID"
}

variable "ansible_service_account_display_name" {
  description = "Display name for ansible service account"
}

variable "ansible_service_account_role" {
  description = "The role that should be applied to ansible service account"
}

// Ensure that gcloud is within $PATH or provide full path to executable
variable "ansible_service_account_gcloud" {
  description = "Google's gcloud cli executable"
}

variable "ansible_service_account_key_path" {
  description = "Path to created key file for ansible service account"
}
