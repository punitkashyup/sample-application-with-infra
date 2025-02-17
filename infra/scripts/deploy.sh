#!/bin/bash
set -e
cd ../azure
terraform init
terraform apply -auto-approve
bash kubeconfig.sh
cd ../ansible
ansible-playbook -i inventory.ini playbook.yml