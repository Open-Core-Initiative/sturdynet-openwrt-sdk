#!/bin/bash

FEED_CONF="${SDK_HOME}/feeds.conf.default"
CUSTOM_DIR="$(realpath ${1})"
CUSTOM_FEED_DEFAULT="custom"
CUSTOM_FEED="${2:-${CUSTOM_FEED_DEFAULT}}"

if [[ ! -d "${CUSTOM_DIR}" || ! -w "${FEED_CONF}" ]]; then
        echo "Usage: ${0} <custom-feed-directory> [custom-feed-name]" >&2
        echo "Add the custom feed directory into packages feeds available in SDK." >&2
        echo "The custom feed directory must exist and file ${FEED_CONF} must be writable." >&2
        echo "The custom feed name can be set by the second argument (it defaults to '${CUSTOM_FEED_DEFAULT}')." >&2
        exit 1
fi

grep -q "^src-link ${CUSTOM_FEED} " "${FEED_CONF}" && sed -i "/^src-link ${CUSTOM_FEED} /d" "${FEED_CONF}"
echo "src-link ${CUSTOM_FEED} ${CUSTOM_DIR}" >> "${FEED_CONF}"
exec "${SDK_HOME}/scripts/feeds" update "${CUSTOM_FEED}"
