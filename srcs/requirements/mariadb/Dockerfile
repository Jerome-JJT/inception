# syntax=docker/dockerfile:1
FROM alpine:3.15.4

RUN apk add mariadb mariadb-client

COPY mariadb-server.cnf /etc/my.cnf.d/

COPY "./start_db.sh" .
RUN dos2unix "./start_db.sh"
RUN chmod +x "./start_db.sh"

CMD ["./start_db.sh"]
