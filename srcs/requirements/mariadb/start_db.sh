#!/bin/sh

#mysqld_safe --datadir='/var/lib/mysql' & 
mariadbd-safe --datadir='/var/lib/mysql' &
#sleep 3

mkdir /here

#env >> lo.txt

#echo $DB_ROOT_PASSWORD  >> lo.txt
#echo $($DB_USER)  >> lo.txt


# Make sure that NOBODY can access the server without a password
mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD')"
# Kill the anonymous users
mariadb -e "DROP USER ''@'localhost'"
# Kill off the demo database
mariadb -e "DROP DATABASE test"

mariadb -e "CREATE DATABASE $DB_NAME" 
mariadb -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
mariadb -e "GRANT ALL PRIVILEGES on '$DB_NAME'.* to '$DB_USER'@'localhost'"


# Make our changes take effect
mariadb -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param




#CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES on new_wp.* to wpuser@localhost IDENTIFIED 'myp@Ssw0Rd';
#GRANT ALL PRIVILEGES on new_wp.* to wpuser@localhost;

pkill mariadb

mariadbd-safe --datadir='/var/lib/mysql'