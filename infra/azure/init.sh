#!/bin/bash

# Read variables from terraform.tfvars
BACKEND_RG=$(grep backend_resource_group_name terraform.tfvars | cut -d'=' -f2 | tr -d '" ')
BACKEND_SA=$(grep backend_storage_account_name terraform.tfvars | cut -d'=' -f2 | tr -d '" ')
BACKEND_CONTAINER=$(grep backend_container_name terraform.tfvars | cut -d'=' -f2 | tr -d '" ')
BACKEND_KEY=$(grep backend_key terraform.tfvars | cut -d'=' -f2 | tr -d '" ')

# Initialize Terraform with backend config
terraform init \
  -backend-config="resource_group_name=${BACKEND_RG}" \
  -backend-config="storage_account_name=${BACKEND_SA}" \
  -backend-config="container_name=${BACKEND_CONTAINER}" \
  -backend-config="key=${BACKEND_KEY}"