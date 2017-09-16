// Ensure app instance is present
resource "google_compute_instance" "app" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = "${var.tags}"

  // Boot disk for the instance
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  // Networks to attach to the instance
  network_interface {
    network = "${var.network}"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  // Metadata key/value pairs to make available from within the instance
  metadata {
    sshKeys = "${var.username}:${file("${var.public_key_path}")}"
  }
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
