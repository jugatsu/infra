// Configure the Google Cloud provider
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

/* Ensure firewall rule for SSH access to all instances
   is present and configured */
module "firewall_ssh" {
  source        = "../modules/vpc/firewall"
  name          = "default-allow-ssh"
  description   = "Allow SSH from anywhere"
  ports         = ["22"]
  source_ranges = "${var.firewall_ssh_cidr}"
}

// Ensure app instance is present and configured
module "app" {
  source          = "../modules/app"
  name            = "${var.app_name}"
  tags            = "${var.app_tags}"
  disk_image      = "${var.app_disk_image}"
  username        = "${var.app_username}"
  public_key_path = "${var.app_public_key_path}"
  firewall_name   = "${var.app_firewall_name}"
  firewall_ports  = "${var.app_firewall_ports}"
}

// Ensure db instance is present and configured
module "db" {
  source          = "../modules/db"
  name            = "${var.db_name}"
  tags            = "${var.db_tags}"
  disk_image      = "${var.db_disk_image}"
  username        = "${var.db_username}"
  public_key_path = "${var.db_public_key_path}"
  firewall_name   = "${var.db_firewall_name}"
  firewall_ports  = "${var.db_firewall_ports}"
  source_tags     = "${var.db_source_tags}"
  target_tags     = "${var.db_target_tags}"
}
