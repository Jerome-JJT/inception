#!/bin/sh

if [ ! -e ".setuped" ];
then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mariadbd-safe --datadir='/var/lib/mysql' --pid-file='/var/run/mysqld/mysqld.pid' --no-watch
    
    while [ ! -f '/var/run/mysqld/mysqld.pid' ] ;
    do
        echo "wait for service."
        sleep 1
        echo "wait for service..."
        sleep 1
    done
    echo "service started"

    # Make sure that NOBODY can access the server without a password
    mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD')"
    # Kill the anonymous users
    mariadb -e "DROP USER ''@'localhost'"
    # Kill off the demo database
    mariadb -e "DROP DATABASE test"

    mariadb -e "CREATE DATABASE $DB_NAME" 
    mariadb -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'"
    #mariadb -e "SET PASSWORD FOR '$DB_USER'@'%' = PASSWORD('$DB_PASSWORD')"
    mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* to '$DB_USER'@'%'"

    #mariadb -e "select user, host from mysql.user"
    # Make our changes take effect
    mariadb -e "FLUSH PRIVILEGES"
    # Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

    touch .setuped

    pkill mariadb
fi


mariadbd-safe --datadir='/var/lib/mysql'
