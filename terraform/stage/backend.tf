/*

    Initialize GCS backend only. For configuration use backend.tvfars file.

    Usage:

    terraform init -backend-config=backend.tfvars

*/

terraform {
  backend "gcs" {}
}
