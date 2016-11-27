#
# Composer for PHP 7 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV COMPOSER_HOME=/root/composer \
    PATH $COMPOSER_HOME/vendor/bin:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
RUN sed -i "s|apc.enable_cli = 1|apc.enable_cli = 0|" /etc/php/7.0/mods-available/apcu.ini && \
    rm /etc/php/7.0/cli/conf.d/20-xdebug.ini && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer

# Display version information
RUN composer --ansi --version

# Set up the application directory
VOLUME ["/app"]

# Define working directory
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
