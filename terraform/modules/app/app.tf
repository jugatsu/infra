// Ensure app instance is present
module "app_instance" {
  source     = "../gce/vm"
  name       = "${var.name}"
  tags       = "${var.tags}"
  disk_image = "${var.disk_image}"

  access_config = {
    nat_ip = "${google_compute_address.app_ip.address}"
  }

  username        = "${var.username}"
  public_key_path = "${var.public_key_path}"
}

// Ensure static IP address for instance is present
resource "google_compute_address" "app_ip" {
  name = "${var.name}-ip"
}

// Ensure firewall rule for app is present and configured
module "app_firewall" {
  source      = "../vpc/firewall"
  name        = "${var.firewall_name}"
  network     = "${var.network}"
  ports       = "${var.firewall_ports}"
  target_tags = "${var.tags}"
}
