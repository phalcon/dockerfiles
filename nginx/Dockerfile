# Pull base image
FROM phalconphp/ubuntu:14.04.4

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN add-apt-repository -y ppa:nginx/stable \
	&& apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y --force-yes --no-install-recommends \
		nginx \
	&& mkdir /etc/nginx/global \
	&& mkdir /etc/nginx/certs

ADD conf/restrict.conf /etc/nginx/global/restrict.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN usermod -u 1000 www-data \
	&& chown -R www-data:www-data /var/lib/nginx \
    && rm -rf /etc/nginx/sites-enabled/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
