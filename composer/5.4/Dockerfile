#
# Composer for PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV COMPOSER_HOME=/root/composer \
    PATH=$COMPOSER_HOME/vendor/bin:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Composer for PHP 5.4\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":12}"

RUN \
    # Install Composer
    sed -i "s|apc.enable_cli=1|apc.enable_cli=0|" /etc/php5/mods-available/apc.ini \
    && rm -f /etc/php5/conf.d/20-xdebug.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    # Display version information
    && composer --ansi --version

# Set up the application directory
VOLUME ["/app"]

# Define working directory
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
