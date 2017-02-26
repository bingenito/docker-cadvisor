#!/bin/bash -x

REPO_DIR=$PWD
BUILD_PATH='github.com/google/cadvisor'

export GOPATH=$REPO_DIR/go

go get -d $BUILD_PATH

cd $GOPATH/src/$BUILD_PATH
make build

cp cadvisor $REPO_DIR
cd $REPO_DIR

docker build -t armhf-cadvisor:latest -t armhf-cadvisor:$(date +%Y%m%d) .
