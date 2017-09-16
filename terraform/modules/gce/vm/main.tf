// Ensure instance is present
resource "google_compute_instance" "default" {
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

    access_config = ["${var.access_config}"]
  }

  // Metadata key/value pairs to make available from within the instance
  metadata {
    sshKeys = "${var.username}:${file("${var.public_key_path}")}"
  }
}
