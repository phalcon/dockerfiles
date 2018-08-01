# Nginx Dockerfiles

Slimmed-down images to use for production Nginx on Alpine Linux.

## Usage

```sh
$ docker run -d -p 80:80 phalconphp/nginx
```

Open `http://127.0.0.1/nginx-status` to see the status page.

### Attach persistent/shared directories

```sh
docker run \
    -d \
    --name docker-nginx \
    -v <sites-config>:/etc/nginx/sites-enabled/default \
    -v <certs-dir>:/etc/nginx/certs \
    -v <www-dir>:/var/www/mysite \
    -p 80:80 \
    phalconphp/nginx
```

After few seconds, open `http://<host>` to see the welcome page.
