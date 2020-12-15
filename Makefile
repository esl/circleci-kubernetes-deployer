IMAGE_BASE_PATH ?= erlangsolutions

helm_version ?= v3.3.0
helm_hash ?= ff4ac230b73a15d66770a65a037b07e08ccbce6833fbd03a5b84f06464efea45
gcloud_version ?= 320.0.0
tag = ${helm_version}-${gcloud_version}
image = ${IMAGE_BASE_PATH}/circleci-kubernetes-deployer:${tag}

build:
	docker buildx build \
	--cache-from ${image} \
	--build-arg=helm_version=${helm_version} \
	--build-arg=helm_hash=${helm_hash} \
	--build-arg=gcloud_version=${gcloud_version} \
	-t ${image} \
	.

push: build
	docker push ${image}
