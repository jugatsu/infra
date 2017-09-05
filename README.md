# Description

This is infrastructure repository for DevOps course http://otus.ru/lessons/devops-praktiki-i-instrumenty/.

Using the gcloud command-line tool
----------------------------------

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
