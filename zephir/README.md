# Phalcon Zephir

Zephir is a compiled high level language aimed to the creation of C-extensions for PHP

## Supported tags and respective `Dockerfile` links

* `5.4` [(5.4/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/zephir/5.4)
* `5.5` [(5.5/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/zephir/5.5)
* `5.6` [(5.6/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/zephir/5.6)
* `7`, `7.0`, `latest` [(7/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/zephir/7)

This image is updated via pull requests to the `phalconphp/dockerfiles` [GitHub repo](https://github.com/phalcon/dockerfiles).

## What is Zephir?

Zephir, an open source, high-level language designed to ease the creation and maintainability of extensions for PHP with a focus on type and memory safety.

Zephir is a language that addresses the major needs of a PHP developer trying to write and compile code that can be executed by PHP. It is a dynamically/statically typed, some of its features can be familiar to PHP developers.

> [zephir-lang.com](https://zephir-lang.com)

## How to use this image

You can run the default `zephir` command simply:

```
$ docker run -it --rm phalconphp/zephir version
```

You can also pass in additional flags to `zephir`:

```
$ docker run -it --rm -v $(pwd):/zephir phalconphp/zephir builddev --backend=ZendEngine3
```

And you can create alias in order to implement convenient runner. Create file called `/usr/local/bin/zephir` as follows:

```sh
#!/usr/bin/env bash

docker_bin="$(which docker 2> /dev/null)"

# 5.4, 5.5, 5.6, 7, 7.0, latest
PHP_VERSION=7

${docker_bin} run -it --rm \
    --privileged=true \
    -e ZEND_DONT_UNLOAD_MODULES=1 \
    -v $(pwd):/zephir \
    phalconphp/zephir:${PHP_VERSION} "$@"

ret=$?

if [ ${ret} -ne 0 ]; then
    errors="$(pwd)/compile-errors.log"
    if [ -e ${errors} ]; then
        cat ${errors}
    fi
fi
```

Make it executable:

```
$ sudo chmod a+x /usr/local/bin/zephir
```

Test:

```
$ zephir version
0.9.3a-dev
```

## License

View [license](https://github.com/phalcon/zephir/blob/master/LICENSE) information for the software contained in this image.


## Supported Docker versions

This image is officially supported on Docker version 1.12.0.

Support for older versions (down to 1.10) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.
