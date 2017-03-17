# Composer

Composer is a dependency manager for PHP.

## Supported tags and respective `Dockerfile` links

* `5.4` [(5.4/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/composer/5.4)
* `5.5` [(5.5/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/composer/5.5)
* `5.6` [(5.6/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/composer/5.6)
* `7`, `7.0`, `latest` [(7/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/composer/7)

This image is updated via pull requests to the `phalconphp/dockerfiles` [GitHub repo](https://github.com/phalcon/dockerfiles).

## What is Composer?

Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.

Composer is not a package manager in the same sense as Yum or Apt are. Yes, it deals with "packages" or libraries, but it manages them on a per-project basis, installing them in a directory (e.g. vendor) inside your project. By default it does not install anything globally.

> [getcomposer.org](https://getcomposer.org)

## How to use this image

You can run the default `composer` command simply:

```
$ docker run -it --rm phalconphp/composer help
```

You can also pass in additional flags to `composer`:

```
$ docker run -it --rm -v $(pwd):/app phalconphp/composer create-project vendor/project:version target-directory
```

And you can create alias in order to implement convenient runner. Create file called `/usr/local/bin/composer` as follows:

```sh
#!/usr/bin/env bash

mkdir -p ${HOME}/.ssh
mkdir -p ${HOME}/.composer

docker run -it --rm \
    -v $(pwd):/app \
    phalconphp/composer:7 "${*:1}"
```

Make it executable:

```
$ sudo chmod a+x /usr/local/bin/composer
```

Test:

```
$ composer --version
Composer version 1.2.0 2016-07-19 01:28:52
```

## License

View [license](https://github.com/composer/composer/blob/master/LICENSE) information for the software contained in this image.

## Supported Docker versions

This image is officially supported on Docker version 1.12.0.

Support for older versions (down to 1.10) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.
