#!/bin/bash

CUSTOM_FEED_DEFAULT="custom"
CUSTOM_FEED="${1:-${CUSTOM_FEED_DEFAULT}}"
BIN_DIR_DEFAULT="${SDK_HOME}/bin"

if [[ "${1}" == "--help" ]]; then
	echo "Usage: ${0} [custom-feed-name]" >&2
	echo "Compile and build all packages from the custom feed in SDK into the SDK bin output directory." >&2
	echo "The custom feed name can be set by the first argument (it defaults to '${CUSTOM_FEED_DEFAULT}')." >&2
	echo "The SDK bin output directory to build the packages into can be set by adding OUTPUT_DIR=<directory> into MAKEFLAGS environment variable (it defaults to ${BIN_DIR_DEFAULT})." >&2
	echo "It is useful to decrease verbosity of the build process by adding '-s' into MAKEFLAGS environment variable." >&2
	exit 1
fi

cd "${SDK_HOME}"
for I in package/feeds/${CUSTOM_FEED}/*; do
	make ${MAKEFLAGS:=--directory=${SDK_HOME}} "${I}/compile" --jobs${nproc} \
	|| make ${MAKEFLAGS} --jobs=1 V=s "${I}/compile" \
	|| exit 1
done
cd -
