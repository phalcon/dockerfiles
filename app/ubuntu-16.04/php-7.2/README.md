# `phalconphp/ubuntu-16.04:php-7.2`

Application image to use for production with PHP and Nginx.

## Usage

Run the following command to get the Application Docker image:

``` sh
$ docker pull phalconphp/ubuntu-16.04:php-7.2
```

### Simple run

``` sh
$ docker run --name app -p 8081:80 phalconphp/ubuntu-16.04:php-7.2
```

### PHP application example

``` sh
# Host system
$ tree
.
├── docker
│   └── nginx.conf
└── public
    └── index.php

2 directories, 2 files
```

``` php
<?php
// index.php
phpinfo();
```

``` nginx
# nginx.conf
server {
    listen 80 default_server;

    server_name example.com;

    index index.php;
    root /app/public;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass             unix:/run/php/php7.2-fpm.sock;
        fastcgi_index            index.php;

        include                  fastcgi_params;

        fastcgi_param            SCRIPT_FILENAME $document_root$fastcgi_script_name;

        fastcgi_intercept_errors on;
        fastcgi_read_timeout     300;
        fastcgi_buffer_size      16k;
        fastcgi_buffers          4 16k;
    }
}
```

``` sh
# run application
docker run \
    -p 8081:80 \
    -v $(pwd):/app \
    -v $(pwd)/docker/nginx.conf:/etc/nginx/sites-enabled/default:ro \
    phalconphp/ubuntu-16.04:php-7.2
```

### Using custom per-application image

``` sh
$ tree
.
├── docker
│   ├── config
│   │   ├── nginx
│   │   │   └── sites-enabled
│   │   │       └── app.conf
│   │   └── php
│   │       └── app.ini
│   └── provision
│       └── after-build.sh
├── Dockerfile
├─── public
│   └── index.php
└─── storage
    └── logs
```

``` dockerfile
FROM phalconphp/ubuntu-16.04:php-7.2

# It is not an iportant part of our image. However, it is useful to pass these
# variables on building stage for future diagnosing a running application
ARG BUILD_ID=0
ARG VERSION=0.0.1

ENV BUILD_ID=${BUILD_ID} \
    APPLICATION_VERSION=${VERSION} \
    DEBIAN_FRONTEND=noninteractive

LABEL build_id="${BUILD_ID}" \
      version="${VERSION}" \
      description="Our application image" \
      maintainer="John Doe <john@doe.com>" \
      vendor=Acme \
      name="com.acme.images.apps.example"

# "/app" is a working directory as it set in parent image. We copy all files
# inside current working dir. This approach implies that we don't use the
# current container to install PHP dependencies using composer and build any
# preject related stuff. Any required project dependencies should be received
# on host system or via special build images. We're use this image as a real
# container for the application, not as a build system.
COPY . /app

# Copy virtual host, custom PHP configuration and disable default site
RUN rm -f /etc/nginx/sites-enabled/default \
    && cp -R /app/docker/config/nginx/* /etc/nginx/ \
    && ln -s /app/docker/config/php/app.ini /etc/php/7.2/cli/conf.d/999-app.ini \
    && ln -s /app/docker/config/php/app.ini /etc/php/7.2/fpm/conf.d/999-app.ini

# Run custom script after build, e.g cleaning up, custom settings, disabling
# redundant modules, etc
RUN bash /app/docker/provision/after-build.sh

# Expose required ports
EXPOSE 80 443

# Amend parent volumes
VOLUME /app/storage/logs
```

``` sh
# build it
docker build --pull -t phalconphp/example-app:2.0.0 .
```

``` sh
# run it
docker run -p 80:80 phalconphp/example-app:2.0.0
```

### Xdebug

Xdebug is disabled by default. To enable it you'll need pass
`XDEBUG_REMOTE_ENABLE` and/or `XDEBUG_REMOTE_HOST` environment variables.

| Variable                         | Description                               |
| -------------------------------- | ----------------------------------------- |
| `XDEBUG_REMOTE_ENABLE=1`         | This will enable Xdebug.                  |
| `XDEBUG_REMOTE_AUTO_START=1`     | Enable autostart will catch all requests. |
| `XDEBUG_REMOTE_HOST=192.168.0.1` | Xdebug remote host.                       |
| `XDEBUG_REMOTE_PORT=9000`        | Will setup remote host.                   |

If you want to start debug session manually pass variable `XDEBUG_SESSION_START`
via `GET`, `POST` or `COOKIE`. Note: To use this feature you'll need set
`XDEBUG_REMOTE_HOST`.

## Build

To build image from the source just use command as follows:

``` sh
$ build --pull -t phalconphp/ubuntu-16.04:php-7.2 .
```
