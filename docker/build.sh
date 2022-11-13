#!/usr/bin/env bash

DOCKERPATH=`dirname $0`
docker build -t dotbproj $DOCKERPATH | tee ./tmp/dockerbuild.dotbproj.log
