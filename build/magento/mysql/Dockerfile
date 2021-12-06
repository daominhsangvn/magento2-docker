ARG MYSQL_VERSION

FROM mysql:${MYSQL_VERSION}

#RUN mkdir -p /var/log/mysql
#RUN touch /var/log/mysql/general.log && \
#    touch /var/log/mysql/mysql-slow.log && \
#    touch /var/log/mysql/error.log && \
#    chown mysql:mysql /var/log/mysql/general.log && \
#    chown mysql:mysql /var/log/mysql/mysql-slow.log && \
#    chown mysql:mysql /var/log/mysql/error.log

ADD ./build/magento/mysql/initdb/01-create-db.sql /docker-entrypoint-initdb.d
ADD ./build/magento/mysql/config-file.cnf /etc/mysql/conf.d

# forward mysql logs to docker log collector
RUN #ln -sf /dev/stdout /var/lib/mysql/mysql-slow.log

EXPOSE 3306:3306
EXPOSE 33060:33060
