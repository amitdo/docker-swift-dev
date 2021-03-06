IMAGE_NAME := bartoszj/swift-dev
IMAGES := \
	jessie \
	stretch \
	sid \
	trusty \
	xenial \
	yakkety

.PHONY: \
	update \
	build $(IMAGES) \
	rsync

all: update

# Update Dockerfiles using templates
update:
	./update.sh

# Build one image
$(IMAGES):
	docker build -t $(IMAGE_NAME):$(@) $(@)

# Build all images
build: $(IMAGES)
