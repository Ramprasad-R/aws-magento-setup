#!/bin/bash
terraform init
terraform apply -auto-approve -var-file=infra.tfvars -var-file=ami.tfvars