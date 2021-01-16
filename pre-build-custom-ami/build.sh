#!/bin/bash
set -x
packer build apache-php-setup.json > packer-output
AMI_ID=`cat packer-output | grep "ami-"| tail -1 | cut -d ':' -f2 | awk '{$1=$1};1'`
cat<<EOF | tee ../build-app-ami/ami.json
{
  "AMI_ID": "${AMI_ID}"
}
EOF