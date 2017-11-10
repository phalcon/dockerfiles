NAME = phalconphp/php-fpm
VERSION = 7.1
ALIAS = 7.1
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build build release push tag do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build:

docker-build:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .

release: build tag push

push: do-push post-push

tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS)
	docker tag $(NAME):$(VERSION) $(NAME):latest

do-push:
	docker push $(NAME):$(VERSION)
	docker push $(NAME):$(ALIAS)
	docker push $(NAME):latest

post-push:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
