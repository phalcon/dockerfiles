# Phalcon Dockerfiles

To use Phalcon with docker, we make use of these images.

You can either build the image yourself with the docker file which is hosted on this repository simply by doing a `docker build <directoryname>`

Alternatively you can also pull a image from docker.io. For example to pull php-fpm for php7 from registry, all you need to execute is: `docker pull phalconphp/php-fpm:7`

## Using for development
Here's a sample `docker-compose.yml`
```
web:
  image: nginx:latest
  ports:
    - "8080:80"
  volumes:
    - ./src:/src
    - ./nginx.conf:/etc/nginx/conf.d/default.conf
  links:
    - php
php:
  image: phalconphp/php-fpm:7
  volumes:
      - ./src:/var/www/html

```
where `nginx.conf` is default `nginx` config file and is located in same directory as docker-compose.yml
