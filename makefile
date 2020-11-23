#
# img-factory
# docker image building factory
# project makefile
#

# builds and pushes all images under IMG_DIR
# Each dirctory with a Dockerfile builds one docker image
# and tags each image with the parent directory to the dockerfile:
# imgs/PATH/TO/Dockerfile with be tagged with:
# PATH/TO:<TAG>
# where <TAG> read from file imgs/PATH/TO/TAG
IMG_DIR:=imgs
DOCKERFILES:=$(shell find $(IMG_DIR) -name "Dockerfile")
CONTAINERS:=$(foreach dockerfile,$(DOCKERFILES)\
	,$(subst $(IMG_DIR)/,,$(subst /Dockerfile,,$(dockerfile))))

.PHONY: all build push
.DEFAULT: all

all: build push

build: $(foreach container,$(CONTAINERS),build/$(container))

# build image with corresponding dockerfile
build/%: $(IMG_DIR)/%/Dockerfile $(IMG_DIR)/%/TAG
	docker build \
		-t $(subst build/,,$@):$(shell cat $(dir $<)/TAG) \
		-f $< \
		$(IMG_DIR)/$(subst build/,,$@)

push: $(foreach container,$(CONTAINERS),push/$(container))

# push built
push/%:
	docker push $(subst push/,,$@)
