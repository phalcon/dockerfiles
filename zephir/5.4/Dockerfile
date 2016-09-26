#
# Zephir for PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Zephir for PHP 5.4\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":14}"

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN \
    echo "export ZEPHIRDIR=/usr/share/zephir" >> /root/.bashrc \
    && echo "export PATH=$PATH:/usr/share/zephir/bin" >> /root/.bashrc \
    && export ZEPHIRDIR=/usr/share/zephir \
    && export PATH=$PATH:/usr/share/zephir/bin \
    # System update
    && /usr/local/bin/apt-upgrade \
    # Install base stuff
    && /usr/local/bin/apt-install \
        libpcre3-dev \
        gcc \
        make \
        re2c \
    # Install Zephir
    && mkdir -p /usr/share/zephir \
    && git clone --depth=1 -q https://github.com/phalcon/zephir /tmp/zephir \
    && cd /tmp/zephir/parser \
    && phpize --clean \
    && cd /tmp/zephir \
    && ./install -c \
    && chmod +x /docker-entrypoint.sh \
    # Cleanup
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf /tmp/*

# Set up the Zephir directory
VOLUME ["/zephir"]

# Define working directory
WORKDIR /zephir

# Set up the command arguments
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zephir"]
