// Ensure db instance is present
module "db_instance" {
  source          = "../gce/vm"
  name            = "${var.name}"
  tags            = "${var.tags}"
  disk_image      = "${var.disk_image}"
  username        = "${var.username}"
  public_key_path = "${var.public_key_path}"
}

// Ensure firewall rule for db instance is present and configured
module "db_firewall" {
  source        = "../vpc/firewall"
  name          = "${var.firewall_name}"
  network       = "${var.network}"
  ports         = "${var.firewall_ports}"
  source_ranges = "${var.source_ranges}"
  source_tags   = "${var.source_tags}"
  target_tags   = "${var.target_tags}"
}
