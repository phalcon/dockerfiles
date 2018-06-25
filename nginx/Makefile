NAME = phalconphp/nginx
VERSION = 1
ALIAS_1 = 1.12
ALIAS_2 = 1.12.2
ALIAS_3 = latest
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build clean build release push tag do-push post-push

build: pre-build docker-build post-build

pre-build:

post-build: clean

docker-build:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .

release: build tag push

push: do-push post-push

tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS_1)
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS_2)
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS_3)

do-push:
	docker push $(NAME):$(VERSION)
	docker push $(NAME):$(ALIAS_1)
	docker push $(NAME):$(ALIAS_2)
	docker push $(NAME):$(ALIAS_3)

post-push:

clean:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
