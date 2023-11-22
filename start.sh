#!/usr/bin/env bash
#
mkdir -p /var/simplesamlphp/log /var/simplesamlphp/mdq-cache
chown www-data /var/simplesamlphp/log /var/simplesamlphp/mdq-cache

rm -f /var/run/apache2/apache2.pid

env APACHE_LOCK_DIR=/var/lock/apache2 APACHE_RUN_DIR=/var/run/apache2 APACHE_PID_FILE=/var/run/apache2/apache2.pid APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 apache2 -DFOREGROUND
