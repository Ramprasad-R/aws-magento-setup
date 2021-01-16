#!/bin/bash
#Before running this script make sure prebuild-custome-ami is already ran and ami is available

# Setup required AWS infrastructure
cd initial-aws-setup
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

echo "Waiting for DB data load..."
sleep 60

#Create a AMI and update the configuration with the infrastructure for WEBAPP 
cd ../build-app-ami
echo "Starting to build WEP APP AMI.."
packer build -var-file=env.json -var-file=app.json -var-file=infra.json -var-file=ami.json magento-packer.json > packer-output
if [ $? == 0 ]
then
  AMI_ID=`cat packer-output | grep "ami-"| tail -1 | cut -d ':' -f2 | awk '{$1=$1};1'`
  echo "MAGENTO_INSTANCE_AMI = \"${AMI_ID}\""> ../deploy-app/ami.tfvars
else
  exit 1
fi

#Create the Autoscaling and Launch configuration and attach it to Application load balancer
cd ../deploy-app/
terraform init
terraform apply -auto-approve -var-file=infra.tfvars -var-file=ami.tfvars