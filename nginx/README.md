# Nginx Dockerfiles

## Base Docker Image

[phalconphp/ubuntu](https://hub.docker.com/r/phalconphp/ubuntu/)

## Installation

1. Install [Docker](https://www.docker.com/)
2. Download [build](https://hub.docker.com/r/phalconphp/nginx/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull phalconphp/nginx`

## Usage

```sh
$ docker run -d -p 80:80 phalconphp/nginx
```

### Attach persistent/shared directories

```sh
docker run \
    -d \
    --name docker-nginx \
    -v <conf.d-dir>:/etc/nginx/conf.d \
    -v <sites-enabled-dir>:/etc/nginx/sites-enabled \
    -v <certs-dir>:/etc/nginx/certs \
    -v <www-dir>:/var/www/mysite \
    -p 80:80 \
    phalconphp/nginx
```

After few seconds, open `http://<host>` to see the welcome page.
