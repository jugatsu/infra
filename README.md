# Description

This is infrastructure repository for DevOps course http://otus.ru/lessons/devops-praktiki-i-instrumenty/.

### Table of Contents
- [DevOps course](#devops-course)
    - [Lesson 1](#lesson-01)
    - [Lesson 2](#lesson-02)
    - [Lesson 3](#lesson-03)
    - [Lesson 4](#lesson-04)
    - [Lesson 5](#lesson-05)
    - [Lesson 6](#lesson-06)
    - [Lesson 7](#lesson-07)
    - [Lesson 8](#lesson-08)

## Lesson 1

## Lesson 2

## Lesson 3
* https://github.com/jugatsu/practice-git-1
* https://github.com/jugatsu/practice-git-2
* https://github.com/jugatsu/practice-prs

## Lesson 4
* https://github.com/jugatsu/play-with-travis

## Lesson 5
#### Самостоятельное задание

> Исследовать способ подключения к internalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и отписать вариант решения преподавателю.

> Бонусная часть: Предложить вариант решения для подключения из консоли при помощи команды вида ssh internalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу internalhost

**Вариант №1**: используем SSH Port Forwarding

```bash
# строим туннель до хоста 10.156.0.3, расположенного в приватной сети
# ключ -f для запуска в фоне, ключ -N для того, чтобы можно было запуститься
# в фоне, не вводя никакой команды
ak@ak-pc:~$ ssh -f -N -L 2222:10.156.0.3:22 35.198.92.244 -i .ssh/otus-gcp
```
или
```bash
# используя конфиг ssh-клиента
ak@ak-pc:~$ cat .ssh/config
Host bastion-otus-gcp
  HostName 35.198.92.244
  User ak
  IdentityFile "/home/ak/.ssh/otus-gcp"
  ForwardAgent yes

ak@ak-pc:~$ ssh -f -N -L 2222:10.156.0.3:22 bastion-otus-gcp
```

затем
```code
# проверяем, что туннель слушает на 2222 порту
ak@ak-pc:~$ sudo lsof -i :2222 -Pn
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
ssh     8945   ak    5u  IPv6  87976      0t0  TCP [::1]:2222 (LISTEN)
ssh     8945   ak    6u  IPv4  87977      0t0  TCP 127.0.0.1:2222 (LISTEN)

# коннектимся к хосту internalhost
ak@ak-pc:~$ ssh -i .ssh/otus-gcp 127.0.0.1 -p 2222

# мы можем использовать опции StrictHostKeyChecking и UserKnownHostsFile,
# чтобы не делать ssh-keygen -f "/home/ak/.ssh/known_hosts" -R [127.0.0.1]:2222,
# если до этого пробрасывали порт на другие хосты
ak@ak-pc:~$ ssh -i .ssh/otus-gcp 127.0.0.1 -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
```

**Вариант №2:** используем опцию ProxyCommand
```bash
ak@ak-pc:~$ ssh -t -i .ssh/otus-gcp -o ProxyCommand='ssh -q -W %h:%p 35.198.92.244' 10.156.0.3
```
или
```bash
# используя конфиг ssh-клиента
ak@ak-pc:~$ cat .ssh/config
Host internalhost-otus-gcp
  HostName 10.156.0.3
  User ak
  ProxyCommand ssh -q -W %h:%p 35.198.92.244
  IdentityFile "/home/ak/.ssh/otus-gcp"
  ForwardAgent yes

# подключение в одну команду
ak@ak-pc:~$ ssh internalhost-otus-gcp
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.10.0-32-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.


Last login: Fri Sep  1 19:12:16 2017 from 10.156.0.2
ak@someinternalhost:~$
ak@someinternalhost:~$
ak@someinternalhost:~$ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.156.0.3/32 brd 10.156.0.3 scope global ens4
       valid_lft forever preferred_lft forever
ak@someinternalhost:~$

 ```

 **Вариант №3:** использовать возможность ssh для построения poor-man VPN

 `man ssh` на предмет SSH-BASED VIRTUAL PRIVATE NETWORKS :)

## Lesson 6

**Using the gcloud command-line tool**

Create instance with startup script `startup.sh`

```bash
$ gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image=ubuntu-1604-xenial-v20170815a \
  --image-project=ubuntu-os-cloud --machine-type=g1-small \
  --tags puma-server --restart-on-failure \
  --zone=europe-west1-b \
  --metadata-from-file startup-script=startup.sh
```

List all instances

```bash
$ gcloud compute instances list
NAME              ZONE            MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
reddit-app        europe-west1-b  g1-small                   10.132.0.2   104.155.18.203  RUNNING
bastion           europe-west3-a  f1-micro                   10.156.0.2   35.198.92.244   TERMINATED
someinternalhost  europe-west3-a  f1-micro                   10.156.0.3                   TERMINATED
```

Connect to instance
```bash
$ ssh -i ~/.ssh/appuser -l appuser 104.155.18.203
```

Use `journalctl` to view `startup.sh` output
```bash
appuser@reddit-app:~$ sudo journalctl -u google-startup-scripts -f
-- Logs begin at Tue 2017-09-05 18:53:18 UTC. --
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script:     Please see README.md
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script:   Puma starting in single mode...
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script: * Version 3.10.0 (ruby 2.4.1-p111), codename: Russell's Teapot
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script: * Min threads: 0, max threads: 16
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script: * Environment: development
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script: * Daemonizing...
Sep 05 18:54:43 reddit-app sudo[8558]: pam_unix(sudo:session): session closed for user appuser
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO startup-script: Return code 0.
Sep 05 18:54:43 reddit-app startup-script[1920]: INFO Finished running startup scripts.
Sep 05 18:54:44 reddit-app systemd[1]: Started Google Compute Engine Startup Scripts.

```

Delete instance
```bash
$ gcloud compute instances delete reddit-app --zone europe-west1-b
```

## Lesson 7
**Using packer to build images**

#### Prepare new project
Create project
```bash
$ gcloud projects create otus-infra --name "Infra for DevOps course" --set-as-default
```
Add ssh keys (https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys)
```bash
$ gcloud compute project-info add-metadata --metadata-from-file ssh-keys=keys.yml
```
List billing accounts
```bash
$ gcloud alpha billing accounts list
ID                    NAME                   OPEN
0090E8-0919B4-38C230  Мой платежный аккаунт  True
```
Link default project to billing account
```bash
$ gcloud alpha billing projects link otus-infra --billing-account 0090E8-0919B4-38C230
billingAccountName: billingAccounts/0090E8-0919B4-38C230
billingEnabled: true
name: projects/otus-infra/billingInfo
projectId: otus-infra
```
List available APIs
```bash
$ gcloud service-management list --available --filter='NAME:compute*'
NAME                    TITLE
compute.googleapis.com  Google Compute Engine API
```
Enable Google Compute Engine API for default project
```bash
$ gcloud service-management enable compute.googleapis.com
Waiting for async operation operations/projectSettings.d6449c8a-575b-4d07-9792-184990c64187 to complete...
Operation finished successfully. The following command can describe the Operation details:
gcloud service-management operations describe operations/projectSettings.d6449c8a-575b-4d07-9792-184990c64187
```
Create firewall rules
```bash
$ gcloud compute firewall-rules create allow-puma-tcp --allow tcp:9292 --target-tags=puma-server
Creating firewall...
...........Created [https://www.googleapis.com/compute/v1/projects/otus-infra/global/firewalls/allow-puma-tcp].
done.
NAME            NETWORK  DIRECTION  PRIORITY  ALLOW     DENY
allow-puma-tcp  default  INGRESS    1000      tcp:9292
```
#### Acquire new user credentials to use for building packer images
```bash
$ gcloud auth application-default login
$ cat ~/.config/gcloud/application_default_credentials.json
```
or you can create separate service account
```bash
# create service account
$ gcloud iam service-accounts create gcp-account --display-name="Service account for using with DevOps tools"
Created service account [gcp-account].
# create file gcp-account.json with service key
$ gcloud iam service-accounts keys create --iam-account gcp-account@otus-infra.iam.gserviceaccount.com gcp-account.json
# add roles
$ gcloud projects add-iam-policy-binding otus-infra \
> --member='serviceAccount:gcp-account@otus-infra.iam.gserviceaccount.com' \
> --role='roles/iam.serviceAccountActor'
> --role='roles/compute.instanceAdmin.v1'
```

#### Build base image with packer
Check a template for components
```bash
$ packer inspect ubuntu16.json
Required variables:

  project_id
  source_image_family

Optional variables and their defaults:

  account_file        =
  disk_name           =
  disk_size           = 10
  disk_type           = pd-standard
  image_description   = Image with base stack for running reddit app.
  image_family        =
  image_name          = reddit-base
  machine_type        = f1-micro
  network             = default
  ssh_username        = appuser
  startup_script_file =
  tags                =
  zone                = europe-west1-b

Builders:

  googlecompute

Provisioners:

  shell
  shell
```
Check that a template is valid
```bash
$ packer validate \
-var project_id=otus-infra \
-var source_image_family=ubuntu-1604-lts \
ubuntu16.json
```
Build image
```bash
$ packer build \
-var project_id=otus-infra \
-var source_image_family=ubuntu-1604-lts \
-var account_file=credentials/gcp-account.json \
-var tags=puma-server \
ubuntu16.json
```
_Notes:_

`account_file` is using for providing json file with service account credentials.
`tags` is using for demonstration purpose only. This option doesn't make any sense in build time in our environment.

Create instance for testing image
```bash
$ gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image=reddit-base-v20170910-1505034508 \
--machine-type=g1-small \
--tags puma-server --restart-on-failure \
--zone=europe-west1-b \
--metadata-from-file startup-script=scripts/startup.sh
```
_Notes:_

`startup-script` is using to deploy reddit app. Reuse code as much as possible.

Check that everything created without errors
```bash
$ ssh -i ~/.ssh/appuser -l appuser 35.187.24.168
$ sudo journalctl -u google-startup-scripts -f
-- Logs begin at Sun 2017-09-10 09:21:48 UTC. --
Sep 10 09:22:27 reddit-app startup-script[1938]: INFO startup-script:     Please see README.md
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script:   Puma starting in single mode...
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script: * Version 3.10.0 (ruby 2.4.1-p111), codename: Russell's Teapot
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script: * Min threads: 0, max threads: 16
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script: * Environment: development
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script: * Daemonizing...
Sep 10 09:22:28 reddit-app sudo[1964]: pam_unix(sudo:session): session closed for user appuser
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO startup-script: Return code 0.
Sep 10 09:22:28 reddit-app startup-script[1938]: INFO Finished running startup scripts.
Sep 10 09:22:28 reddit-app systemd[1]: Started Google Compute Engine Startup Scripts.
$ sudo lsof -i :9292
COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
ruby    2497 appuser   10u  IPv4  21168      0t0  TCP *:9292 (LISTEN)
```

#### Build immutable image with packer
Build image
```bash
$ packer build \
-var project_id=otus-infra \
-var source_image_family=ubuntu-1604-lts \
-var account_file=credentials/gcp-account.json \
-var tags=puma-server \
immutable.json
```
_Notes:_

`File` provisioner is using for uploading `systemd` unit `puma` to image.
`Shell` provisioner is using for enabling `puma` service. Use it `inline` so we don't need to create separate shell script.

Testing newly created immutable image
```bash
$ gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image=reddit-full-stack-v20170910-1505035639 \
--machine-type=g1-small \
--tags puma-server --restart-on-failure \
--zone=europe-west1-b

$ sudo journalctl -u puma
-- Logs begin at Sat 2017-09-09 08:33:14 UTC, end at Sat 2017-09-09 08:34:15 UTC. --
Sep 09 08:33:23 reddit-app systemd[1]: Started Puma HTTP Server.
Sep 09 08:33:25 reddit-app puma[1508]: Puma starting in single mode...
Sep 09 08:33:25 reddit-app puma[1508]: * Version 3.10.0 (ruby 2.4.1-p111), codename: Russell's Teapot
Sep 09 08:33:25 reddit-app puma[1508]: * Min threads: 0, max threads: 16
Sep 09 08:33:25 reddit-app puma[1508]: * Environment: development
Sep 09 08:33:26 reddit-app puma[1508]: /home/appuser/reddit/helpers.rb:4: warning: redefining `object_id' may cause serious problems
Sep 09 08:33:26 reddit-app puma[1508]: D, [2017-09-09T08:33:26.434130 #1508] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
Sep 09 08:33:26 reddit-app puma[1508]: D, [2017-09-09T08:33:26.434325 #1508] DEBUG -- : MONGODB | Server 127.0.0.1:27017 initializing.
Sep 09 08:33:26 reddit-app puma[1508]: D, [2017-09-09T08:33:26.436073 #1508] DEBUG -- : MONGODB | Topology type 'unknown' changed to type 'single'.
Sep 09 08:33:26 reddit-app puma[1508]: D, [2017-09-09T08:33:26.436156 #1508] DEBUG -- : MONGODB | Server description for 127.0.0.1:27017 changed from 'unknown' to 'standalone'.
Sep 09 08:33:26 reddit-app puma[1508]: D, [2017-09-09T08:33:26.436227 #1508] DEBUG -- : MONGODB | There was a change in the members of the 'single' topology.
Sep 09 08:33:26 reddit-app puma[1508]: * Listening on tcp://0.0.0.0:9292
Sep 09 08:33:26 reddit-app puma[1508]: Use Ctrl-C to stop

appuser@reddit-app:~$ sudo lsof -i :9292
COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
ruby    1512 appuser   10u  IPv4  19556      0t0  TCP *:9292 (LISTEN)
```
Delete image
```bash
$ gcloud compute instances delete reddit-app --zone europe-west1-b
```

## Lesson 8
**Using terraform to define infrastructure as code**

```bash
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_firewall.firewall_puma
      id:                                                  <computed>
      allow.#:                                             "1"
      allow.931060522.ports.#:                             "1"
      allow.931060522.ports.0:                             "9292"
      allow.931060522.protocol:                            "tcp"
      destination_ranges.#:                                <computed>
      name:                                                "allow-puma-default"
      network:                                             "default"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     "1"
      source_ranges.1080289494:                            "0.0.0.0/0"
      target_tags.#:                                       "1"
      target_tags.1799682348:                              "reddit-app"

  + google_compute_instance.app
      id:                                                  <computed>
      boot_disk.#:                                         "1"
      boot_disk.0.auto_delete:                             "true"
      boot_disk.0.device_name:                             <computed>
      boot_disk.0.disk_encryption_key_sha256:              <computed>
      boot_disk.0.initialize_params.#:                     "1"
      boot_disk.0.initialize_params.0.image:               "reddit-base-v20170910-1505034508"
      boot_disk.0.source:                                  <computed>
      can_ip_forward:                                      "false"
      create_timeout:                                      "4"
      label_fingerprint:                                   <computed>
      machine_type:                                        "g1-small"
      metadata.%:                                          "1"
      metadata.sshKeys:                                    "appuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl/5z5W9kOtBPfwp3eCtnBD54kIE2FrgH6j2JoEaYUgh0k3ZygoFFPPClCvfptP6gzon8chtvLBnVKLhEiYoZrcfL/qZHvQ/2WXIPY6xwmKkUiachYMB8St+bQ6KctpWEpPfUPpb0rzvZNDltGps/BEcNRHH8Q8WijAZNpLwSlevAKpvpwzYlJF+J0UlDVoEMN6xG+IkSWcBJ46sqTBvbfBTBC7Mmux2VGN/l+CXlv+DtTGWBAA9vC421+zPPAi0gFyW2t8LftR9z+QGYpCbcWq3zYuu0YoqJQ3mK/3ZcNLoLYVixr0RsxVsesgUf/dqvVby2SAAd7qfEvEnjMRpGv appuser\n"
      metadata_fingerprint:                                <computed>
      name:                                                "reddit-app"
      network_interface.#:                                 "1"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.address:                         <computed>
      network_interface.0.name:                            <computed>
      network_interface.0.network:                         "default"
      network_interface.0.subnetwork_project:              <computed>
      scheduling.#:                                        <computed>
      self_link:                                           <computed>
      tags.#:                                              "1"
      tags.1799682348:                                     "reddit-app"
      tags_fingerprint:                                    <computed>
      zone:                                                "europe-west1-b"


Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```
