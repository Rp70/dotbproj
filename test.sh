#!/usr/bin/env bash


docker run -it --rm \
    -h dotbproj-test \
    -v $PWD:/dotbproj:ro \
    -u www-data \
    -w /var/www-data \
    dotbproj bash
