#!/bin/bash

set -e

# 参数1：版本号（必填）
TAG=$1
# 参数2：架构，默认amd64
ARCH=${2:-amd64}

if [ -z "$TAG" ]; then
  echo "Usage: $0 <version-tag> [arch]"
  echo "Example: $0 1.0.3 arm64"
  exit 1
fi

echo "Building apinto version: $TAG for architecture: $ARCH"

OUT_DIR=./out/apinto-${TAG}-${ARCH}

# 清理旧目录准备新目录
rm -rf ${OUT_DIR}
mkdir -p ${OUT_DIR}

# 这里填入你项目的包路径，假设 main 包在 ./app/apinto
# 交叉编译命令
CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -ldflags "\
  -w -s \
  -X 'github.com/eolinker/apinto/utils/version.Version=${TAG}' \
  -X 'github.com/eolinker/apinto/utils/version.gitCommit=$(git rev-parse HEAD)' \
  -X 'github.com/eolinker/apinto/utils/version.buildTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")' \
  -X 'github.com/eolinker/apinto/utils/version.buildUser=$(whoami)' \
  -X 'github.com/eolinker/apinto/utils/version.goVersion=$(go version)' \
  " -o ${OUT_DIR}/apinto ./app/apinto

# 进入生成目录打包
cd ./out
tar czvf apinto_${TAG}_linux_${ARCH}.tar.gz apinto-${TAG}-${ARCH}
cd -

echo "Package created at ./out/apinto_${TAG}_linux_${ARCH}.tar.gz"
