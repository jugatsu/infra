// Ensure service account for ansible dynamic GCE inventory is present
module "service_account" {
  source       = "../modules/service_account"
  account_id   = "${var.ansible_service_account_account_id}"
  display_name = "${var.ansible_service_account_display_name}"
  project      = "${var.project}"
  role         = "${var.ansible_service_account_role}"
  gcloud       = "${var.ansible_service_account_gcloud}"
  key_path     = "${var.ansible_service_account_key_path}"
}

output "ansible_gce_configuration" {
  value = <<EOF

  Add following configuration to gcp.ini:

  gce_service_account_email_address = ${var.ansible_service_account_account_id}@${var.project}.iam.gserviceaccount.com
  gce_service_account_pem_file_path = ${var.ansible_service_account_key_path}
  gce_project_id = ${var.project}
EOF
}
