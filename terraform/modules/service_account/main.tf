// Ensure IAM policy is binded to service account
resource "google_project_iam_binding" "default" {
  project = "${var.project}"
  role    = "${var.role}"

  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
}

// Ensure Google Cloud Platform service account is present
resource "google_service_account" "default" {
  account_id   = "${var.account_id}"
  display_name = "${var.display_name}"
}

/* Terraform's Google Provider doesn't support creating keys yet.
   See https://github.com/terraform-providers/terraform-provider-google/issues/400
   Use null_resource instead to create keys using local-exec provisioner. */
resource "null_resource" "create_key" {
  triggers = {
    account = "${google_service_account.default.email}"
  }

  // Create key using gcloud cli
  provisioner "local-exec" {
    command = <<EOT
account=$(${var.gcloud} iam service-accounts list --format='value(email)' --filter='displayName:${var.display_name}'); \
${var.gcloud} iam service-accounts keys create --iam-account $account ${var.key_path}
EOT
  }
}
