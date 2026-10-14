FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

COPY index.html /var/www/html/index.html
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /run/mysqld \
    && chown mysql:mysql /run/mysqld \
    && mariadb-install-db --user=mysql --datadir=/var/lib/mysql

EXPOSE 80 3306

CMD ["/usr/bin/supervisord", "-n"]
