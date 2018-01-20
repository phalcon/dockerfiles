NAME = phalconphp/php-apache
TAG = ubuntu-16.04
SHELL = /bin/bash
PHP_VERSION= 7.0
ARTIFACTS_IMAGE = klay/mkimage:$(TAG)-php-$(PHP_VERSION)

.PHONY: pre-build docker-build post-build clean build release push do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build: clean

docker-build:
	docker pull $(ARTIFACTS_IMAGE)
	docker create --name extract $(ARTIFACTS_IMAGE)
	docker cp extract:/artifacts ./artifacts
	docker rm -f extract
	docker build -t $(NAME):$(TAG) .

release: build push

push: do-push post-push

do-push:
	docker push $(NAME):$(TAG)

post-push:

clean:
	rm -rf ./artifacts

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
