#
# Composer for PHP 7 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:alpine-php7-min

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer

# Display version information
RUN composer --ansi --version

# Set up the application directory
VOLUME ["/app"]

# Define working directory
WORKDIR /app

# Set up the command arguments
CMD ["composer"]
