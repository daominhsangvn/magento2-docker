ARG MYSQL_VERSION

FROM mysql:${MYSQL_VERSION}

RUN mkdir -p /var/log/mysql
#RUN chown mysql:mysql /var/log/mysql
ADD ./build/magento/mysql/initdb/01-create-db.sql /docker-entrypoint-initdb.d
#ADD ./build/magento/mysql/initdb/05-config.sql /docker-entrypoint-initdb.d
ADD ./build/magento/mysql/config-file.cnf /etc/mysql/conf.d

EXPOSE 3306:3306
EXPOSE 33060:33060
