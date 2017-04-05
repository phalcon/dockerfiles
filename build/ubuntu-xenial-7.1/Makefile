NAME = phalconphp/build
TAG = ubuntu-xenial-7.1
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build clean build release push do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build: clean

docker-build:
	docker build -t $(NAME):$(TAG) --no-cache --rm .

release: build push

push: do-push post-push

do-push:
	docker push $(NAME):$(TAG)

post-push:

clean:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
