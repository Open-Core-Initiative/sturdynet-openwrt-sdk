#!/bin/bash

if [[ "${1}" == "--help" ]]; then
	echo "Usage: ${0} [...]" >&2
	echo "Execute make in the SDK home directory with given arguments." >&2
	exit 1
fi

make ${MAKEFLAGS:=--directory=${SDK_HOME}} $@ \
|| make ${MAKEFLAGS} --jobs=1 V=s $@
