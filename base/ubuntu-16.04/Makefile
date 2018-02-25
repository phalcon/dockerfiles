VENDOR_NAME = phalconphp
IMAGE_NAME ?= base
IMAGE_TAG ?= ubuntu-16.04
FQIN = $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: build
build:
	docker build \
		--pull \
		--compress \
		--force-rm \
		-t $(FQIN) \
		--no-cache \
		--rm .

.PHONY: release
release: build push

.PHONY: push
push:
	docker push $(FQIN)

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
