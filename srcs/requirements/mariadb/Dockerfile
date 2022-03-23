# syntax=docker/dockerfile:1
FROM alpine


RUN apk add nano mariadb mariadb-client

COPY mariadb-server.cnf /etc/my.cnf.d/

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

COPY "./start_db.sh" .
RUN dos2unix "./start_db.sh"
RUN chmod +x "./start_db.sh"

CMD ["./start_db.sh"]
