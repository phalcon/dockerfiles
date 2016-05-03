#
# Composer for PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV COMPOSER_HOME /root/composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm /etc/php5/conf.d/20-xdebug.ini

# Display version information
RUN composer --ansi --version

# Set up the application directory
VOLUME ["/app"]

# Define working directory
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
