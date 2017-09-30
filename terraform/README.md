# Terraform for Google Cloud Platform (GCP)

Terraform configuration of GCP infrastructure for running reddit-app https://github.com/Artemmkin/reddit.

Google Cloud Storage (GCS) is used as a Terraform backend https://www.terraform.io/docs/backends/types/gcs.html.

Folder structure:

* **modules**: Terraform Modules
* **prod**: production environment
* **stage**: staging environment

## Terraform modules

* **app**: create and configure frontend instance
* **db**: create and configure database instance
* **vm**: create GCE instance
* **firewall**: create and configure firewall

## Usage

1. Initialize GCS backend. Use `backend.tfvars.example` as an example:
```bash
terraform init -backend-config=backend.tfvars
```
2. Configure Terraform variables. Use `terraform.tfvars.example` as an example.
3. Create an execution plan using `terraform plan` command.
4. Apply the changes required to reach the desired state of the configuration using `terraform apply` command.
