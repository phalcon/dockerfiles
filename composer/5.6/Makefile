NAME = phalconphp/composer
VERSION = 5.6
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build build release push do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build:

docker-build:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .

release: build push

push: do-push post-push

do-push:
	docker push $(NAME):$(VERSION)

post-push:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
