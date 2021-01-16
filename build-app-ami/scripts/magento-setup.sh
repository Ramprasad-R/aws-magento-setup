#!/bin/bash
set -x

mkdir -p /etc/apache2/sites-available

cat<<EOF | tee /etc/apache2/sites-available/magento.conf
<VirtualHost *:80>
     DocumentRoot /var/www/html/magento/
     ServerName ${base_url_domain}
     ServerAlias ${base_url_domain}

     <Directory /var/www/html/magento/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
     </Directory>

     ErrorLog $APACHE_LOG_DIR/magento_error.log
     CustomLog $APACHE_LOG_DIR/magento_access.log combined
</VirtualHost>
EOF

a2ensite magento.conf
a2enmod rewrite

sed -i 's/memory_limit.*/memory_limit 2G/' /etc/php/7.4/apache2/php.ini

systemctl restart apache2

wget -O /var/www/html/magento.tar.gz --user=${ARTIFACT_USER} --password=${ARTIFACT_PASSWORD} ${APP_ARTIFACT_URL}
cd /var/www/html/
tar -xzf magento.tar.gz
cd magento

sed "s/{{ mysql_host }}/${mysql_host}/g;s/{{ mysql_user }}/${mysql_user}/g;\
s/{{ mysql_password }}/${mysql_password}/g;s/{{ mysql_db }}/${mysql_db}/g;\
s/{{ redis_server }}/${redis_server}/g;s/{{ redis_port }}/${redis_port}/g;\
s/{{ base_url_domain }}/${base_url_domain}/g;" /tmp/env.php.j2 > /var/www/html/magento/app/etc/env.php

/var/www/html/magento/bin/magento config:set catalog/search/engine 'elasticsearch7'
/var/www/html/magento/bin/magento config:set catalog/search/elasticsearch7_server_hostname "${elastic_search_endpoint}"
/var/www/html/magento/bin/magento config:set catalog/search/elasticsearch7_server_port '443'
/var/www/html/magento/bin/magento config:set catalog/search/elasticsearch7_enable_auth '0'


/var/www/html/magento/bin/magento indexer:reindex catalogsearch_fulltext
/var/www/html/magento/bin/magento cache:clean
rm -rf /var/www/html/magento/var/cache/*
rm -rf /var/www/html/magento/var/generation/*

chown -R :www-data /var/www/html/magento

rm -rf /var/www/html/magento.tar.gz

echo "* * * * * aws s3 sync /var/www/html/magento/pub/static s3://${static_bucket_name}/" > /tmp/crontab
echo "* * * * * aws s3 sync /var/www/html/magento/pub/media s3://${media_bucket_name}/" >> /tmp/crontab
crontab /tmp/crontab
