CREATE DATABASE IF NOT EXISTS `magento`;
CREATE USER 'magento'@'%' IDENTIFIED BY 'magento';
ALTER USER 'magento'@'%' IDENTIFIED WITH mysql_native_password BY 'magento';
GRANT ALL PRIVILEGES ON magento.* TO 'magento'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
