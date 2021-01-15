#!/bin/bash
set -x
sudo apt update
sudo apt install mysql-client -y
wget -O /tmp/magento.sql --user=${ARTIFACT_USER} --password=${ARTIFACT_PASSWORD} ${SQL_ARTIFACT_URL}
sudo sed -i 's/DEFINER=[^*]*\*/\*/g' /tmp/magento.sql
sudo sed -i '/MYSQLDUMP_TEMP_LOG_BIN/d' /tmp/magento.sql
sudo sed -i '/SESSION.SQL_LOG_BIN/d' /tmp/magento.sql
sudo sed -i '/GLOBAL.GTID_PURGED/d' /tmp/magento.sql
echo "update core_config_data set value='${base_url}' where path like '%base_url%';" >> /tmp/magento.sql
if grep base_media_url /tmp/magento.sql > /dev/null
then
  echo "update core_config_data set value='${base_media_url}' where path like '%base_media_url%';" >>/tmp/magento.sql
else 
  echo "insert into core_config_data (scope, scope_id, path, value) VALUES ('default', 0, 'web/secure/base_media_url', '${base_media_url}');" >>/tmp/magento.sql
  echo "insert into core_config_data (scope, scope_id, path, value) VALUES ('default', 0, 'web/unsecure/base_media_url', '${base_media_url}');" >>/tmp/magento.sql
fi
if grep base_static_url /tmp/magento.sql > /dev/null
then
  echo "update core_config_data set value='${base_static_url}' where path like '%base_static_url%';" >> /tmp/magento.sql
else
  echo "insert into core_config_data (scope, scope_id, path, value) VALUES ('default', 0, 'web/unsecure/base_static_url', '${base_static_url}');" >>/tmp/magento.sql
  echo "insert into core_config_data (scope, scope_id, path, value) VALUES ('default', 0, 'web/secure/base_static_url', '${base_static_url}');">>/tmp/magento.sql
fi
sudo mysql -h ${mysql_host} -u ${RDS_USERNAME} -p${RDS_PASSWORD} magento < /tmp/magento.sql
rm -rf /tmp/magento.sql