#!/bin/bash

CUSTOM_FEED_DEFAULT="custom"
CUSTOM_FEED="${1:-${CUSTOM_FEED_DEFAULT}}"

if [[ "${1}" == "--help" ]]; then
	echo "Usage: ${0} [custom-feed-name]" >&2
	echo "Install sources of all packages from the custom feed into SDK." >&2
	echo "The custom feed name can be set by the first argument (it defaults to '${CUSTOM_FEED_DEFAULT}')." >&2
	exit 1
fi

exec "${SDK_HOME}/scripts/feeds" install -a -p "${CUSTOM_FEED}"
