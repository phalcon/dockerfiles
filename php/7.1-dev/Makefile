NAME = phalconphp/php
TAG = 7.1-dev
ALIAS = latest-dev
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build clean build tag release push do-push post-push

build: pre-build docker-build post-build

pre-build:
	tar -cvf base.tar \
		usr \
		installers

post-build: clean

docker-build:
	docker build -t $(NAME):$(TAG) --no-cache --rm .

release: build tag push

push: do-push post-push

tag:
	docker tag $(NAME):$(TAG) $(NAME):$(ALIAS)

do-push:
	docker push $(NAME):$(TAG)
	docker push $(NAME):$(ALIAS)

post-push:

clean:
	rm -f base.tar

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
