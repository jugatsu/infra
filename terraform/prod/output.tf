// Define output variable with google project ID
output "google_project" {
  description = "The ID of the project"
  value       = "${var.google_project}"
}

// Define output variable with google region
output "google_region" {
  description = "The region to operate under"
  value       = "${var.google_region}"
}

// Define output variable with frontend external ip
output "app_external_ip" {
  description = "External IP for frontend instance"
  value       = "${module.app.app_external_ip}"
}

// Define output variable with database external ip
output "db_external_ip" {
  description = "External IP for database instance§"
  value       = "${module.db.db_external_ip}"
}

// Define output variable with database internal ip
output "db_internal_ip" {
  description = "Internal IP for database instance"
  value       = "${module.db.db_internal_ip}"
}
