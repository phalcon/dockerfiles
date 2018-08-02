# Phalcon Dockerfiles

Dockerfiles from Phalcon for PHP, Apache and Nginx (with PHP5 and PHP7) and more.

![phalccon-images](https://raw.githubusercontent.com/phalcon/dockerfiles/master/docs/phalccon-images-1533189242.png)

You can either build the image yourself with the docker file which is hosted on this repository simply by doing a `docker build <directoryname>`

Alternatively you can also pull a image from docker.io. For example to pull php-fpm for php7 from registry, all you need to execute is: `docker pull phalconphp/php-fpm:7`

## Using for development

Here's a sample `docker-compose.yml`

```yaml
version: '3.2'

services:

  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./src:/src
      - ./web-site.conf:/etc/nginx/sites-enabled/default
    links:
      - php

  php:
    image: phalconphp/php-fpm:7-min
    volumes:
        - ./src:/var/www/html

```
where `nginx.conf` is default `nginx` config file and is located in same directory as docker-compose.yml

## Supported Docker versions

These images is officially supported on Docker >= 1.13.0.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.
