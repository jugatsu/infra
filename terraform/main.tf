// Configure the Google Cloud provider
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

// Ensure instance is present
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]

  // Boot disk for the instance
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  // Networks to attach to the instance
  network_interface {
    network       = "default"
    access_config = {}
  }

  // Metadata key/value pairs to make available from within the instance
  metadata {
    sshKeys = "appuser:${file("${var.public_key_path}")}"
  }

  connection {
    type        = "ssh"
    user        = "${var.username}"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  }

  // Copy puma systemd unit to instance to reuse in deploy script
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  // Deploy reddit app
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
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
