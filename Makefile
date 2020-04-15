# Building docker image
TAG = "v1.0.0"
LATEST_TAG = "v1.0.0"
DOCKER_IMAGE = phenoscape/phenoscape-pipeline-tools

build:
	docker build -t $(DOCKER_IMAGE):$(TAG) . 

tag-latest:
	docker tag $(DOCKER_IMAGE):$(LATEST_TAG) $(DOCKER_IMAGE):latest

run:
	docker run --rm -ti --name phenoscape-pipeline-tools $(DOCKER_IMAGE)

publish: build
	docker push $(DOCKER_IMAGE):$(TAG)
	docker push $(DOCKER_IMAGE):latest
