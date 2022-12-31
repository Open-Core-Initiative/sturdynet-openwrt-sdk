FROM ubuntu:22.04

LABEL \
maintainer="Prajval Raval <ravalprajval@gmail.com>"

ARG OPENWRT_ARCH
ARG OPENWRT_GCC
ARG OPENWRT_HOST
ARG OPENWRT_TARGET
ARG OPENWRT_SUBTARGET
ARG OPENWRT_VERSION

ENV \
OPENWRT_ARCH="${OPENWRT_ARCH:-arm_cortex-a7_neon-vfpv4}" \
OPENWRT_GCC="${OPENWRT_GCC:-11.2.0_musl_eabi}" \
OPENWRT_HOST="${OPENWRT_HOST:-Linux-x86_64}" \
OPENWRT_TARGET="${OPENWRT_TARGET:-ipq40xx}" \
OPENWRT_SUBTARGET="${OPENWRT_SUBTARGET:-generic}" \
OPENWRT_VERSION="${OPENWRT_VERSION:-22.03.1}"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

ENV \
SDK_NAME="openwrt-sdk-22.03.1-ipq40xx-generic_gcc-11.2.0_musl_eabi.Linux-x86_64"

ENV \
SDK_URL="https://runners-cache-sturdynet.s3.us-west-2.amazonaws.com/sdk/openwrt-sdk-22.03.1-ipq40xx-generic_gcc-11.2.0_musl_eabi.Linux-x86_64.tar.xz" \
SDK_HOME="/opt/${SDK_NAME}"

ENV \
MAKEFLAGS="--directory=${SDK_HOME} MM_SHM_MAXSEGSIZE=67108864"

COPY scripts /

RUN true \
# make the scripts executable
&& chmod 755 /*.sh \
# download and enter SDK
&& apt update \
&& apt install -y build-essential clang flex g++ gawk gcc-multilib gettext \
git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev wget file \
&& echo "Downloading ${SDK_URL} ..." && mkdir -p "${SDK_HOME%/*}" && wget -qO - "${SDK_URL}" | tar xJ -C "${SDK_HOME%/*}" && echo "OpenWrt SDK downloaded and extracted" \
&& cd "${SDK_HOME}" \
# configure SDK
&& /reconfigure.sh \
# download packages
&& ./scripts/feeds update -a \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
