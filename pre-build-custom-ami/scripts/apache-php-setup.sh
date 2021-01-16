#!/bin/bash

cat <<EOF >> /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu bionic main multiverse restricted universe
deb http://archive.ubuntu.com/ubuntu bionic-security main multiverse restricted universe
deb http://archive.ubuntu.com/ubuntu bionic-updates main multiverse restricted universe
EOF

apt-get update

apt install -y apache2 

apt install awscli -y

apt install -y php7.4 libapache2-mod-php7.4 php7.4-gmp php7.4-curl \
php7.4-soap php7.4-bcmath php7.4-intl php7.4-mbstring php7.4-xmlrpc \
php7.4-mysql php7.4-gd php7.4-xml php7.4-cli php7.4-zip php7.4-common

systemctl start apache2
systemctl enable apache2