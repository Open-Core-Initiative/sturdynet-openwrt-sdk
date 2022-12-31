#!/bin/bash

KEYFILE="${1}"

if [[ -z "${KEYFILE}" ]]; then
	echo "Usage: ${0} <private-key-file-for-signing-package-index>" >&2
	echo "The private and public key pair will be generated if the private key file does not exist." >&2
	exit 1
fi

[[ -r "${KEYFILE}" ]] \
|| ${SDK_HOME}/staging_dir/host/bin/usign -G -s "${KEYFILE}" -p "${KEYFILE}.pub"

ln -vsf ${KEYFILE} ${SDK_HOME}/key-build
exec make ${MAKEFLAGS:=--directory=${SDK_HOME}} package/index
