#!/bin/bash
echo -e "\e[41mCAUTION! This will delete your entire cluster\e[0m"
read -r -p "Are you sure? [y/N] : " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]
then
  cd deploy-app
  terraform destroy -auto-approve -var-file=infra.tfvars -var-file=ami.tfvars
  cd ../initial-aws-setup
  terraform destroy -auto-approve
else
  exit 1
fi