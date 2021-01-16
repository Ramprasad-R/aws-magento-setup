#!/bin/bash
set -x
# packer build apache-php-setup.json > packer-output
AMI_ID=`cat packer-output | grep "us-east-2: ami" | cut -d ':' -f2 | awk '{$1=$1};1'`
cat<<EOF | tee ../deploy-app/ami.json
{
  "AMI_ID": "${AMI_ID}"
}
EOF
