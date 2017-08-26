#!/bin/bash -x

REPO_DIR=$PWD
BUILD_PATH='github.com/google/cadvisor'
CADVISOR_VERSION="v0.26.1"

export GOPATH=$REPO_DIR/go
mkdir -p $GOPATH $REPO_DIR/docker

go get -d -u $BUILD_PATH

cd $GOPATH/src/$BUILD_PATH
git checkout $CADVISOR_VERSION
make build

cp cadvisor $REPO_DIR/docker
cd $REPO_DIR/docker

docker build -t armhf-cadvisor:latest -t armhf-cadvisor:$(echo $CADVISOR_VERSION | tr -d '[:alpha:]') .

cd $REPO_DIR
