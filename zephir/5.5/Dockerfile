#
# Zephir for PHP 5.5 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.5

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV ZEPHIRDIR /usr/share/zephir

# Install Zephir
RUN mkdir -p /usr/share/zephir && \
    git clone --depth=1 -v https://github.com/phalcon/zephir /tmp/zephir && \
    cd /tmp/zephir && \
    ./install -c && \
    cd / && rm -rf /tmp/zephir

# Set up the application directory
VOLUME ["/zephir"]

# Define working directory
WORKDIR /zephir

# Set up the command arguments
ENTRYPOINT ["zephir"]
CMD ["help"]
