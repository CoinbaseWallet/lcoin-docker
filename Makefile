VERSION?=v1.0.0-beta.15-petejkim-2

DOCKER_REPO?=petejkim/lcoin
DOCKER_FULLTAG=$(DOCKER_REPO):$(VERSION)

# LCOIN_CHECKOUT?=tags/$(VERSION)
LCOIN_CHECKOUT?=32140347ddbbbf8883a700f46a9add5942bce234

build:
	@echo "building: $(DOCKER_FULLTAG)"
	@docker build -t $(DOCKER_FULLTAG) \
		--build-arg LCOIN_VERSION=$(LCOIN_CHECKOUT) \
		.

# Current option for latest:
latest: build
	@echo "Tagging latest"
	@docker tag $(DOCKER_FULLTAG) $(DOCKER_REPO):latest

master: DOCKER_TAG=master
master: LCOIN_CHECKOUT=master
master: build

.PHONY: build latest
