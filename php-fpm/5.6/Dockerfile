#
# PHP-FPM 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.6

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV PHP_MEMORY_LIMIT=512M \
    MAX_UPLOAD=50M \
    PHP_MAX_FILE_UPLOAD=200 \
    PHP_MAX_POST=100M

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -yq --no-install-suggests --no-install-recommends --force-yes php5.6-fpm

# Tune up PHP FPM
RUN sed -i -e "s|;catch_workers_output\s*=.*|catch_workers_output = yes|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|^pm.max_children =.*|pm.max_children = 9|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|^pm.start_servers =.*|pm.start_servers = 3|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|^pm.min_spare_servers =.*|pm.min_spare_servers = 2|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|^pm.max_spare_servers =.*|pm.max_spare_servers = 4|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|;pm.max_requests =.*|pm.max_requests = 200|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e "s|;security.limit_extensions =.*|security.limit_extensions = .php|g" /etc/php/5.6/fpm/pool.d/www.conf

# Tune up PHP
RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/5.6/fpm/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php/5.6/fpm/php.ini && \
    sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php/5.6/fpm/php.ini && \
    sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php/5.6/fpm/php.ini && \
    sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php/5.6/fpm/php.ini && \
    sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php/5.6/fpm/php.ini && \
    sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php/5.6/fpm/php.ini && \
    sed -i 's|display_errors =.*|display_errors = On|' /etc/php/5.6/fpm/php.ini && \
    sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php/5.6/fpm/php.ini && \
    sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php/5.6/fpm/php.ini

# Fix ownership of sock file for php-fpm
RUN sed -i -e "s|;listen.mode =.*|listen.mode = 0750|g" /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e 's|^listen =.*|listen = 0.0.0.0:9000|g' /etc/php/5.6/fpm/pool.d/www.conf && \
    sed -i -e 's|^listen.allowed_clients|;listen.allowed_clients|g' /etc/php/5.6/fpm/pool.d/www.conf && \
    chown -R www-data:www-data /etc/php/5.6/fpm/ && \
    usermod -u 1000 www-data

RUN phpenmod -s fpm phalcon xdebug

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stderr /var/log/php5.6-fpm.log

# Cleanup package manager
RUN apt-get autoremove && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php5 /etc/php/5.5 /etc/php/7.0 /usr/lib/php/7.0 /usr/lib/php/20121212 /usr/lib/php/20151012

# Expose ports
EXPOSE 9000 9001

# Expose volumes
VOLUME ["/etc/php/5.6/fpm/pool.d/"]

ENTRYPOINT ["php-fpm5.6", "-F"]
