provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

resource "github_repository" "ansible_role_mongodb" {
  name        = "ansible-role-mongodb"
  description = "Ansible Role for MongoDB (https://www.mongodb.com)"
  has_issues = true
  allow_rebase_merge = false
  allow_squash_merge = false
}
