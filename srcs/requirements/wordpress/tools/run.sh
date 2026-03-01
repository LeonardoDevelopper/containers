#!/bin/bash

set -e

DB_PASSWORD="$(cat /run/secrets/db_password)"

cd /var/www/html

if [ ! -f wp-config.php ]; then
    wp core download --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="${DB_HOST}" \
        --allow-root
    
    wp core install \
        --url="${DOMAIN_NAME}"  \
        --title="${WP_TITLE}"   \
        --admin_user="${WP_ADMIN_USER}"    \
        --admin_password="${WP_ADMIN_PASSWORD}"    \
        --admin_email="${WP_ADMIN_EMAIL}"   \
        --allow-root

wp user create "${WP_EDITOR_USER}" "${WP_EDITOR_EMAIL}" \
    --role=editor \
    --user_pass="${WP_EDITOR_PASSWORD}" \
    --allow-root
fi

# Nginx speaks FastCGI over TCP to service name `php-fpm:9000`.
sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm8.2 -F
