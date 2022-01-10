#!/bin/sh
WP="./wp-cli.phar --path=/wordpress"

if [ ! -e /wordpress/index.php ]
then
	$WP core download
else
	echo "Already downloaded"
fi

$WP core install --url=$S_URL --title=$S_TITLE --admin_email=$S_ADMIN_MAIL --admin_user=$S_ADMIN --admin_password=$S_ADMIN_PASS
$WP user create $S_USER $S_USER_MAIL --user_pass=$S_USER_PASS

php-fpm7 --nodaemonize