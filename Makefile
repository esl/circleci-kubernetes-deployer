IMAGE_BASE_PATH ?= erlangsolutions

build:
	docker build . -t ${IMAGE_BASE_PATH}/circleci-kubernetes-deployer:latest

push: build
	docker push ${IMAGE_BASE_PATH}/circleci-kubernetes-deployer:latest
