FROM phalconphp/build:alpine-3.4 AS build-env

ENV SETUP_DIR=/installers \
    NGINX_VERSION=1.12.2 \
    NGINX_CONF_PATH=/etc/nginx \
    NGINX_LOG_PATH=/var/log/nginx \
    NGINX_USER=www-data \
    NGINX_BUILD=Alpine \
    PCRE_VERSION=8.42 \
    PCRE_PATH=/opt/prce

RUN apk update \
    && apk upgrade --force

COPY ./installers $SETUP_DIR

RUN bash $SETUP_DIR/nginx.sh \
    && rm -rf /tmp/* /var/cache/apk/* \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

# ------------------------------------------------------------

FROM phalconphp/base:alpine-3.4 

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache \
        geoip-dev \
        jansson-dev \
        pcre-dev \
    && mkdir -p \
        /var/lock \
        /var/run \
        /var/log/nginx \
        /opt/geoip \
    && rm -rf /etc/nginx \
    && git clone --depth=1 -q https://github.com/h5bp/server-configs-nginx /etc/nginx

COPY --from=build-env /opt/prce /opt/prce
COPY --from=build-env /usr/sbin/nginx /usr/sbin/nginx
COPY configs /
COPY var /var

RUN tar xf /opt/geoip/GeoLite.tar.gz -C /opt/geoip \
    && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

ARG BUILD_ID=0
ARG VERSION=0.0.1

ENV BUILD_ID=${BUILD_ID} \
    VERSION=${VERSION}

LABEL description="Slimmed-down image to use for production Nginx on Alpine Linux" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.nginx-1.12" \
    build_id="${BUILD_ID}" \
    version="${VERSION}"

COPY ./entrypoint.sh /entrypoint.sh
RUN mkdir -p \
        /usr/share/nginx/client_body_temp \
        /var/cache/nginx \
        /var/www/html \
        /spool/nginx/proxy_temp \
        /entrypoint.d \
    && chmod +x /entrypoint.sh\
    && rm -rf /tmp/* /var/cache/apk/* \
    && rm -f /opt/geoip/GeoLite.tar.gz \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

EXPOSE 80 443
VOLUME ["/var/log/nginx"]

ENTRYPOINT ["/entrypoint.sh"]
