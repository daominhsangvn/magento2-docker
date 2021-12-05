ARG MYSQL_VERSION

FROM mysql:${MYSQL_VERSION}

RUN mkdir -p /var/log/mysql
RUN touch /var/log/mysql/general.log && \
    touch /var/log/mysql/slow.log && \
    touch /var/log/mysql/error.log && \
    chown mysql:mysql /var/log/mysql/general.log && \
    chown mysql:mysql /var/log/mysql/slow.log && \
    chown mysql:mysql /var/log/mysql/error.log

#RUN chown mysql:mysql /var/log/mysql
ADD ./build/magento/mysql/initdb/01-create-db.sql /docker-entrypoint-initdb.d
#ADD ./build/magento/mysql/initdb/05-config.sql /docker-entrypoint-initdb.d
ADD ./build/magento/mysql/config-file.cnf /etc/mysql/conf.d

EXPOSE 3306:3306
EXPOSE 33060:33060
