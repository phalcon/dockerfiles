#
# Composer for PHP 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.6

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV COMPOSER_HOME /root/composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

# Memory Limit
RUN sed -i "s|memory_limit =.*|memory_limit = -1|" /usr/local/phpenv/versions/$(phpenv global)/etc/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm -f /usr/local/phpenv/versions/$(phpenv global)/etc/conf.d/xdebug.ini

# Display version information
RUN composer --ansi --version

# Set up the application directory
VOLUME ["/app"]

# Define working directory
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
