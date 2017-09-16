variable "app_disk_image" {
  description = ""
}
variable "db_disk_image" {
  description = ""
}

variable "project" {
  description = "The ID of the project"
}

variable "public_key_path" {
  description = ""
}

variable "region" {
  default     = "europe-west1"
  description = "The region to operate under"
}
