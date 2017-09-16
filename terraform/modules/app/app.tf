// Ensure app instance is present
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]

  // Boot disk for the instance
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  // Networks to attach to the instance
  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  // Metadata key/value pairs to make available from within the instance
  metadata {
    sshKeys = "appuser:${file("${var.public_key_path}")}"
  }
}

// Ensure static IP address for instance is present
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

// Ensure firewall rules are present
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow = {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
