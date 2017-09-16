// Ensure db instance is present
resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-db"]

  // Boot disk for the instance
  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
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
}

// Ensure firewall rule for MongoDB is present
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"

  allow = {
    protocol = "tcp"
    ports    = ["27017"]
  }

  target_tags = ["reddit-app"]
  source_tags = ["reddit-app"]
}
