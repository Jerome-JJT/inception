# syntax=docker/dockerfile:1
FROM alpine


RUN apk add nano mariadb mariadb-client

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

#RUN 

COPY my.cnf /etc/mysql.d/

#RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY "./start_db.sh" .
RUN dos2unix "./start_db.sh"

CMD ["./start_db.sh"]
