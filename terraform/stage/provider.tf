// Configure the Google Cloud provider
provider "google" {
  version = "~> 0.1"

  project = "${var.google_project}"
  region  = "${var.google_region}"
}
