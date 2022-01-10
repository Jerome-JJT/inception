# syntax=docker/dockerfile:1
FROM alpine


RUN apk add curl nano
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar

RUN apk add php php-json php-phar php-openssl php-iconv php-mysqli php-fpm

COPY php.ini /etc/php7/
COPY www.conf /etc/php7/php-fpm.d/

RUN mkdir /wordpress
COPY wp-config.php /wordpress

COPY php.ini /etc/php7/
COPY www.conf /etc/php7/php-fpm.d/


COPY "./start_wordpress.sh" .
RUN dos2unix "./start_wordpress.sh"

CMD ["./start_wordpress.sh"]
