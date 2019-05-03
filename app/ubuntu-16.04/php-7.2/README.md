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
