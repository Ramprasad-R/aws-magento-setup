#!/bin/bash
set -x
packer build -var-file=env.json -var-file=app.json -var-file=infra.json -var-file=ami.json magento-packer.json > packer-output
if [ $? == 0 ]
then
  AMI_ID=`cat packer-output | grep "ami-"| tail -1 | cut -d ':' -f2 | awk '{$1=$1};1'`
  echo "MAGENTO_INSTANCE_AMI = \"${AMI_ID}\""> ../deploy-app/ami.tfvars
else
  exit 1
fi
