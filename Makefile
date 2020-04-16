# Building docker image
TAG = v1.0.0
DOCKER_IMAGE = phenoscape/pipeline-tools

build-tag:
	docker build -t $(DOCKER_IMAGE):$(TAG) .

publish-tag: build-tag
	docker push $(DOCKER_IMAGE):$(TAG)

tag-latest: build-tag
	docker tag $(DOCKER_IMAGE):$(TAG) $(DOCKER_IMAGE):latest

publish-latest: tag-latest
	docker push $(DOCKER_IMAGE):latest
