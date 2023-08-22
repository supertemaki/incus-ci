#!/usr/bin/env sh
set -eux

apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
  distrobuilder

apk add --no-cache \
  bash \
  git \
  rsync \
  tar
