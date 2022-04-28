## syntax=docker/dockerfile:1
FROM alpine:3.15.4 AS build

RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=CH/ST=Vaud/L=./CN=localhost' -keyout nginx-selfsigned.key -out nginx-selfsigned.crt


FROM alpine:3.15.4

COPY --from=build nginx-selfsigned.key nginx-selfsigned.crt .

RUN apk add nginx

COPY mysite.conf /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
