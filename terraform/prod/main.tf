// Configure the Google Cloud provider
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

// Ensure app instance is present
module "app" {
  source          = "../modules/app"
  app_disk_image  = "${var.app_disk_image}"
  public_key_path = "${var.public_key_path}"
}

// Ensure db instance is present
module "db" {
  source          = "../modules/db"
  db_disk_image   = "${var.db_disk_image}"
  public_key_path = "${var.public_key_path}"
}

// Ensure firewall is configured
module "vpc" {
  source        = "../modules/vpc"
  source_ranges = "176.77.38.68/32"
}
