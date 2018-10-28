#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-demystifypay/demystifyd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/demystifyd docker/bin/
cp $BUILD_DIR/src/demystify-cli docker/bin/
cp $BUILD_DIR/src/demystify-tx docker/bin/
strip docker/bin/demystifyd
strip docker/bin/demystify-cli
strip docker/bin/demystify-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
