# Description

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

This repo contains code for running Reddit-like app https://github.com/Artemmkin/reddit on Google Cloud Platform (GCP) using the following tools:
* [terraform](https://www.terraform.io)
* [packer](https://www.packer.io)
* [ansible](https://github.com/ansible/ansible)

This project was done by the knowledge gained in the DevOps course http://otus.ru/lessons/devops-praktiki-i-instrumenty/.

# Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
- [Support](#support)
- [Contributing](#contributing)
- [License](#license)

# Requirements
[(Back to top)](#table-of-contents)

Install the following tools:

* `terraform` https://www.terraform.io/intro/getting-started/install.html
* `packer` https://www.packer.io/docs/install/index.html
* `ansible` http://docs.ansible.com/ansible/latest/intro_installation.html

You also need to have access to Google Cloud Platform https://cloud.google.com. Get if for free https://cloud.google.com/free/

# Usage
[(Back to top)](#table-of-contents)

Folder structure:

* [ansible](https://github.com/jugatsu/infra/tree/master/ansible): ansible roles to provision full stack to run our application.
* [packer](https://github.com/jugatsu/infra/tree/master/packer): packer templates to build GCP images which are used to run our application.
* [terraform](https://github.com/jugatsu/infra/tree/master/terraform): terraform configuration files to provision infrastructure on GCP to run our application.

See `README.md` in each folder for the additional details.

# Support
[(Back to top)](#table-of-contents)

Please [open an issue](https://github.com/jugatsu/infra/issues/new) for support.

# Contributing
[(Back to top)](#table-of-contents)
Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/jugatsu/infra/compare/).

# License
[(Back to top)](#table-of-contents)

[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)

Please have a look at the [LICENSE.md](LICENSE.md) for more details.
