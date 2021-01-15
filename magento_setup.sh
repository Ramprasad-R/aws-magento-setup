#!/bin/bash
cd initial-setup 
# terraform init && terraform apply -auto-approve
terraform output > output.cfg
sed -i 's/ = /=/g' output.cfg
sed -i 's/"//g' output.cfg
jq -Rs '[ split("\n")[] | select(length > 0) | split("=") | {(.[0]): .[1]} ] | add' output.cfg > ../deploy-app/infra.json
cd ../deploy-app
packer build -var-file=env.json -var-file=infra.json magento-packer.json