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

    # Kill the anonymous users
    mariadb -e "DROP USER ''@'localhost'"
    mariadb -e "DROP USER ''@'"$(hostname)"'"
    # Kill off the demo database
    mariadb -e "DROP DATABASE test"

    mariadb -e "CREATE DATABASE $DB_NAME"
    mariadb -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'"
    
    mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* to '$DB_USER'@'%'"

    # Make our changes take effect
    mariadb -e "FLUSH PRIVILEGES"
    # Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA '' USING PASSWORD('$DB_ROOT_PASSWORD')";

    touch .setuped

    pkill mariadb
fi


mariadbd-safe --datadir='/var/lib/mysql'

