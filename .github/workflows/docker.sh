#!/bin/sh

set -ex

image='ghcr.io/pinkiebell/go-ethereum'
tag=$(git tag --points-at HEAD)

if [ -z "$tag" ]; then
  tag='latest'
fi

echo $image:$tag
docker buildx create --name mybuilder --use || echo 'skip'
docker buildx inspect --bootstrap
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 -t $image:$tag --push .
docker buildx imagetools inspect $image:$tag
