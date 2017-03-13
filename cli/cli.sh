#!/bin/bash

GCLOUD_WORKSPACE="$WORKSPACE/gcloud-cluster"
GID="$(id -g $USER)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  DOCKER_GID="staff"
else # linux
  DOCKER_GID="$(getent group docker | cut -d: -f3)"
fi

is-exited() {
	local container=$1
	[[ $(docker inspect --format "{{.State.Status}}" $container 2>/dev/null) == "exited" ]]
}

if ! is-exited gcloud-config; then
  mkdir -p $HOME/.config
  mkdir -p $HOME/.kube

  docker run -it \
    -u $UID:$GID \
    -v $HOME/.kube:/.kube \
    -v $HOME/.config:/.config \
    --name gcloud-config google/cloud-sdk gcloud init

  docker run -it --rm \
    -u $UID:$GID \
    --volumes-from=gcloud-config \
    google/cloud-sdk gcloud auth application-default login
fi

docker build -t gcloud-cli $GCLOUD_WORKSPACE/cli

docker run -it --rm \
  -u $UID:$GID \
  --group-add $DOCKER_GID \
  -e GID=$GID \
  -e GCLOUD_WORKSPACE=$GCLOUD_WORKSPACE \
  --volumes-from=gcloud-config \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $GCLOUD_WORKSPACE/cli/bashrc:/.bashrc \
  -v $GCLOUD_WORKSPACE:$GCLOUD_WORKSPACE \
  -w $GCLOUD_WORKSPACE \
  gcloud-cli