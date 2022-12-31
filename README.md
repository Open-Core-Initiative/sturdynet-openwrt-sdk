# OpenWrt SDK Docker Image

[![pipeline status](https://gitlab.com/rychly-edu/docker/docker-openwrt-sdk/badges/master/pipeline.svg)](https://gitlab.com/rychly-edu/docker/docker-openwrt-sdk/commits/master)
[![coverage report](https://gitlab.com/rychly-edu/docker/docker-openwrt-sdk/badges/master/coverage.svg)](https://gitlab.com/rychly-edu/docker/docker-openwrt-sdk/commits/master)

## Run

~~~sh
docker pull registry.gitlab.com/rychly-edu/docker/docker-openwrt-sdk:latest
docker run -it --rm registry.gitlab.com/rychly-edu/docker/docker-openwrt-sdk:latest
~~~

### Usage

~~~sh
wget -qO - https://my-hosting/openwrt-packages-source.tgz | tar xz
export MAKEFLAGS="${MAKEFLAGS} OUTPUT_DIR=/openwrt-packages-source/bin -s"
/add-custom-local-feed.sh /openwrt-packages-source
/install-custom-feed-packages.sh
/reconfigure.sh
/make-custom-feed-packages.sh
/make-index.sh /openwrt-packages-source/key-build
mkdir -p /openwrt-packages-source/public
/generate-repository.sh /openwrt-packages-source/public /openwrt-packages-source/key-build.pub /openwrt-packages-source/bin
~~~

## Build

### The Latest Version by Docker

~~~sh
docker build --pull -t "registry.gitlab.com/rychly-edu/docker/docker-openwrt-sdk:latest" .
~~~

### All Versions by the Build Script

~~~sh
./build.sh --build "registry.gitlab.com/rychly-edu/docker/docker-openwrt-sdk" "latest"
~~~

For the list of versions to build see [docker-tags.txt file](docker-tags.txt).
