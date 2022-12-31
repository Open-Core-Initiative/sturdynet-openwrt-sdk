#!/bin/bash

if [[ "${1}" == "--help" ]]; then
	echo "Usage: ${0}" >&2
	echo "Reconfigure SDK to disable build of all target specific packages, all kernel module packages, and all userspace packages, and enable the remaining (custom) packages built as modules by default." >&2
	exit 1
fi

rm "${SDK_HOME}/.config"
make ${MAKEFLAGS:=--directory=${SDK_HOME}} defconfig
sed -i -e 's/^\(CONFIG_ALL_NONSHARED=\).*$/\1n/' -e 's/^\(CONFIG_ALL_KMODS=\).*$/\1n/' -e 's/^\(CONFIG_ALL=\).*$/\1n/' "${SDK_HOME}/.config"
make ${MAKEFLAGS} oldconfig
