#
# Zephir for PHP 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.6

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV ZEPHIRDIR=/usr/share/zephir \
    PATH=$PATH:/usr/share/zephir/bin \
    ZEND_DONT_UNLOAD_MODULES=1

# Install Zephir
RUN \
    mkdir -p /usr/share/zephir \
    && git clone --depth=1 -v git://github.com/phalcon/zephir /usr/share/zephir \
    && cd /usr/share/zephir \
    && (cd parser && phpize --clean) \
    && echo "#!/usr/bin/env bash\nexec \"\$@\"" | tee /usr/bin/sudo \
    && chmod +x /usr/bin/sudo \
    && ./install -c \
    && rm -f /etc/php/5.6/cli/conf.d/20-redis.ini \
    # Install Zephir Parser
    && git clone --depth=1 -v git://github.com/phalcon/php-zephir-parser.git /tmp/parser \
    && cd /tmp/parser \
    && ./install \
    && echo extension=zephir_parser.so | tee /etc/php/5.6/cli/conf.d/20-zephir_parser.ini \
    && php --ri "Zephir Parser" \
    && zephir help \
    && apt-get autoremove \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the Zephir directory
VOLUME ["/code"]

# Define working directory
WORKDIR /code

# Set up the command arguments
ENTRYPOINT ["/usr/share/zephir/bin/zephir"]
