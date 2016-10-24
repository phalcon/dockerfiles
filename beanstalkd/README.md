# Dockerized beanstalkd

This is beanstalkd, a fast, general-purpose work queue.

## Supported tags and respective `Dockerfile` links

* `1`, `1.10`, `latest` [(1.10/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/beanstalkd/1.10)

This image is updated via pull requests to the `phalconphp/dockerfiles` [GitHub repo](https://github.com/phalcon/dockerfiles).

## What is Beanstalk?

Beanstalk is a simple, fast work queue.

Its interface is generic, but was originally designed for reducing the latency of page views in high-volume web applications by running time-consuming tasks asynchronously.

> [kr.github.io/beanstalkd](http://kr.github.io/beanstalkd/)

## How to use this image

You can run the default `beanstalkd` command simply:

```
$ docker run -d -p 11300:11300 phalconphp/beanstalkd
```

The above example exposes the Beanstalk on port 11300, so that you can use it in your application.

You can also pass in additional flags to `beanstalkd`:

```
$ docker run -d -p 11300:11300 phalconphp/beanstalkd -VVV -b /var/lib/beanstalkd
```

And you can create alias in order to implement convenient runner. Create file called `/usr/local/bin/beanstalkd` as follows:

```sh
#!/usr/bin/env bash

# docker volume create --name=beanstalk

docker_bin="$(which docker 2> /dev/null)"

${docker_bin} run -d \
    -p 127.0.0.1:11300:11300 \
    -v beanstalk:/var/lib/beanstalkd \
    phalconphp/beanstalkd "$@"
```

Make it executable:

```
$ sudo chmod a+x /usr/local/bin/beanstalkd
```

Test:

```
$ beanstalkd
```

## License

View [license](https://github.com/kr/beanstalkd/blob/master/LICENSE) information for the software contained in this image.


## Supported Docker versions

This image is officially supported on Docker version 1.12.0.

Support for older versions (down to 1.10) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.
