#!/bin/bash
terraform init
terraform apply -auto-approve
if [ $? == 0 ]
then
  terraform output > output.cfg
  sed -i 's/ = /=/g' output.cfg
  sed -i 's/"//g' output.cfg
  jq -Rs '[ split("\n")[] | select(length > 0) | split("=") | {(.[0]): .[1]} ] | add' output.cfg > ../build-app-ami/infra.json
  terraform output > ../deploy-app/infra.tfvars
else
  exit 1
fi