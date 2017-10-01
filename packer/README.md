# Packer GCE templates

Packer templates for building Google Compute Engine (GCE) images.

For additional information about GCE builder's configuration see https://www.packer.io/docs/builders/googlecompute.html

Folder structure:

* **app.json**: template for building image with Ruby installed.
* **db.json**: template for building image with MongoDB installed.
* **base.json**: template for building image with Ruby and MongoDB installed.
* **immutable.json**: template for building image with full stack for running reddit-app https://github.com/Artemmkin/reddit

## Invoking the template

You must provide `project_id` and `source_image_family` when running Packer.

Invoke `packer` to build an image:
```bash
packer build -var 'project_id=YOUR_PROJECT_ID' -var 'source_image_family=ubuntu-1604-lts' base.json
```

## Provisioners

This templates are using the `ansible` Packer provisioner https://www.packer.io/docs/provisioners/ansible.html

The following playbooks are used:
* [packer_ruby.yml](https://github.com/jugatsu/infra/blob/master/ansible/playbooks/packer_ruby.yml): provision Ruby.
* [packer_mongodb.yml](https://github.com/jugatsu/infra/blob/master/ansible/playbooks/packer_mongodb.yml): provision MongoDB.
* [packer_base.yml](https://github.com/jugatsu/infra/blob/master/ansible/playbooks/packer_base.yml): provision Ruby and MongoDB.
* [packer_immutable.yml](https://github.com/jugatsu/infra/blob/master/ansible/playbooks/packer_immutable.yml): provision full stack for running reddit-app https://github.com/Artemmkin/reddit
