#
# PHP-CLI 7.1 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM php:7.1-cli

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV PHALCON_VERSION 3.2.1

RUN cd /tmp \
	&& curl -sSLO https://codeload.github.com/phalcon/cphalcon/tar.gz/v$PHALCON_VERSION \
	&& tar xvzf v$PHALCON_VERSION  \
	&& cd cphalcon-$PHALCON_VERSION/build \
	&& ./install \
	&& echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& apt-get clean -y \
    && rm -rf \
    	/var/lib/apt/lists/* \
    	/tmp/* \
    	/var/tmp/* \
    	/etc/php5 \
    	/etc/php/5* \
    	/usr/lib/php/20121212 \
    	/usr/lib/php/20131226 \
    	/var/log \
    	/var/cache
