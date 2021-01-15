#!/bin/bash
set -x
sudo apt update
sudo apt install mysql-client -y
wget -O /tmp/magento.sql --user=${ARTIFACT_USER} --password=${ARTIFACT_PASSWORD} ${SQL_ARTIFACT_URL}
sudo sed -i 's/DEFINER=[^*]*\*/\*/g' /tmp/magento.sql
sudo sed -i '/MYSQLDUMP_TEMP_LOG_BIN/d' /tmp/magento.sql
sudo sed -i '/SESSION.SQL_LOG_BIN/d' /tmp/magento.sql
sudo sed -i '/GLOBAL.GTID_PURGED/d' /tmp/magento.sql
sudo mysql -h ${mysql_host} -u ${RDS_USERNAME} -p${RDS_PASSWORD} magento < /tmp/magento.sql
rm -rf /tmp/magento.sql