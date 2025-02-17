#!/bin/bash
set -e
cd ../azure
./setup-backend.sh
./init.sh
terraform apply -auto-approve