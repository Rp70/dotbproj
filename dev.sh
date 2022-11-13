#!/usr/bin/env bash


docker run -it --rm \
    --privileged \
    --cap-add=SYS_ADMIN \
    -h dotbproj \
    -v $PWD:/dotbproj:rw \
    -w /dotbproj \
    dotbproj bash
