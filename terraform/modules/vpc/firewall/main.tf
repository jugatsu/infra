// Ensure firewall rule is present and configured
resource "google_compute_firewall" "firewall" {
  name        = "${var.name}"
  description = "${var.description}"
  network     = "${var.network}"

  allow = {
    protocol = "${var.protocol}"
    ports    = "${var.ports}"
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = "${var.target_tags}"
  source_tags   = "${var.source_tags}"
}
