VENDOR_NAME = phalconphp
BUILD_ID ?= $(shell /bin/date "+%Y%m%d-%H%M%S")

ifneq ("$(wildcard ./VERSION)","")
VERSION ?= $(shell cat ./VERSION | head -n 1)
else
VERSION ?= ubuntu-16.04
$(shell echo $(VERSION) > ./VERSION)
endif

IMAGE_NAME ?= base
IMAGE_TAG ?= $(VERSION)

.PHONY: build
build:
	docker build \
		--build-arg VERSION=$(VERSION) \
		--build-arg BUILD_ID=$(BUILD_ID) \
		--pull \
		-t $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) \
		--no-cache \
		--rm .

.PHONY: release
release: build push

push:
	docker push $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
