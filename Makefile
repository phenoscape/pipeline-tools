# Building docker image
VERSION = "v1.0.0"
IM = phenoscape/pipeline-tools

build:
	docker build -t $(IM):$(VERSION) . \
	&& docker tag $(IM):$(VERSION) $(IM):latest