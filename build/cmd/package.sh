#!/bin/bash

TAG=$1
ARCH=${2:-amd64}

echo "Building for arch=${ARCH}"

OUT_DIR=./out/apinto-${TAG}-${ARCH}
rm -rf ${OUT_DIR}
mkdir -p ${OUT_DIR}

# You can add CGO_ENABLED=0 for static build
CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -ldflags "...version info..." -o ${OUT_DIR}/apinto ./app/apinto

# tar.gz package
tar -czvf ./out/apinto_${TAG}_linux_${ARCH}.tar.gz -C ./out apinto-${TAG}-${ARCH}
