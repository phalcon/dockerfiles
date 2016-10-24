NAME = phalconphp/beanstalkd
TAG = 1.10
ALIAS = 1
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build clean build release push do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build: clean

docker-build:
	docker build -t $(NAME):$(TAG) --no-cache --rm .

release: build tag push

push: do-push post-push

tag:
	docker tag $(NAME):$(TAG) $(NAME):$(ALIAS)
	docker tag $(NAME):$(TAG) $(NAME):latest

do-push:
	docker push $(NAME):$(TAG)
	docker push $(NAME):$(ALIAS)
	docker push $(NAME):latest

post-push:

clean:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
