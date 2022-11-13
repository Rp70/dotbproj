FROM ubuntu:18.04
ARG DEBIAN_FONTEND=noninteractive

RUN set -ex \
    && apt update

RUN set -ex \
    && apt install -y sudo curl

RUN set -ex \
    && apt install -y systemd gettext-base

RUN set -ex \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

