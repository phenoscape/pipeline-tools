# Building docker image
VERSION = "v1.0.0"
IM = shalsh/phenoscape-pipeline-tools

build:
	docker build -t $(IM):$(VERSION) . \
	&& docker tag $(IM):$(VERSION) $(IM):latest

run:
	docker run --rm -ti --name phenoscape-pipeline-tools $(IM)

publish: build
	docker push $(IM):$(VERSION) \
	&& docker push $(IM):latest
