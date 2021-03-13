# Simple lab project

## Description
Deploy lab infrastructure in GCP using terraform and configure hosts as prescribed
After infrastructure is deployed, the inventory is enriched with obtained node ip addresses for latter use with ansible.
PostgreSQL is deployed from official repositories, db dumps in this example are stored locally, which might easily be changed if necessary. Also several dumps can be specified for restoration.
Nginx deployment is wrapped in systemd docker unit.

## Requirements
Ansible >= 2.10
Terraform >= 0.14
At least one clean GCP project as a target

## Initial config
Environments are set up `dev`, `stage` and `prod` directories
var/global.yaml contains a set of values, that can partially be overridden in environment definition - the `global` section, that is used as a source for default values in several places:
```yaml
global:
  project: paytech-gcp-lab # Change to the project of your choice
  region: us-central1
  zone: us-central1-c
  os_image: ubuntu-os-cloud/ubuntu-1804-lts
  machine_type: f1-micro
```
Might also be populated with other params (`security.users` for example, or `pgsql.version`) which would behave as expected when used as `extra-vars` upon playbook invocation.

## Usage
To deploy single environment use:

`ansible-playbook -i <env_dir>/hosts spinup.yaml -e @vars/global.yaml --user <ssh_user> --private-key <ssh_private_key>`

After testing environment is destroyed via following:

`ansible-playbook -i <env_dir>/hosts spindown.yaml -e @vars/global.yaml --user <ssh_user> --private-key <ssh_private_key> --tags yes-i-am-sure`

`ssh_user` - username that would be used during infrastructure bootstrap. Please note that ssh public key must reside alongside with private key and have exactly the same naming with `.pub` extension.

Only local terraform states are used, so don't try this in production.
