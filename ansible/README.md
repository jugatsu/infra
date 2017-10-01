# Ansible with GCE dynamic inventory

Ansible repo for deployment and provisioning reddit-app https://github.com/Artemmkin/reddit using Google Compute Engine (GCE) dynamic inventory.

Folder structure:
* **environments**: production and staging inventory files
* **playbooks**: playbooks used by `ansible`[Packer](https://github.com/jugatsu/infra/tree/master/packer) provisioner
* **roles**: folder for ansible roles intalled using `requirements.yml`, see below
* `site.yml`: main playbook
* `app.yml`: playbook to provision frontend on `tag_app` hosts group, see below
* `db.yml`: playbook to provision MongoDB on `tag_db` hosts group, see below
* `requirements.yml`: file used by `ansible-galaxy` to install ansible roles
* `ansible.cfg`: ansible configuration file

## Usage

1. Create `credentials` folder and add GCE json file with service account credentials into it.
1. Configure GCE dynamic inventory using `gce.ini` http://docs.ansible.com/ansible/latest/guide_gce.html
1. Install ansible roles with `ansible-galaxy -r requirements.yml install -p roles`
1. Check if everything configured with `ansible all -m ping`

Notes: `gce.py` groups hosts based on GCE network tag into ansible groups prefixed with `tag_`.
