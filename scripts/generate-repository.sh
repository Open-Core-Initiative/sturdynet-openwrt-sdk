#!/bin/bash

REPO_DIR="${1}"
KEYFILE="${2}"
BIN_DIR_DEFAULT="${SDK_HOME}/bin"
BIN_DIR="${3:-${BIN_DIR_DEFAULT}}"
PUBLIC_KEY="${4}"

if [[ ! -d "${REPO_DIR}" || ! -r "${KEYFILE}" ]]; then
	echo "Usage: ${0} <directory-to-publish-into> <public-key-file-for-package-index-signature-verification> [sdk-bin-output-directory]" >&2
	echo "Copy the public key, packages, etc. into the directory to publish them." >&2
	echo "The directory to publish and the key file must exist." >&2
	echo "The SDK bin output directory to copy the packages from can be set by the third argument (it defaults to ${BIN_DIR_DEFAULT})." >&2
	exit 1
fi

PUBLIC="${REPO_DIR}/releases/${OPENWRT_VERSION}"

mkdir -p "${PUBLIC}"
# copy packages and the key file
mv -v "${BIN_DIR}/packages" "${KEYFILE}" "${PUBLIC_KEY}" "${PUBLIC}/"
# store SDK name (including its version)
echo "${SDK_NAME}" > "${PUBLIC}/openwrt-sdk.txt"
