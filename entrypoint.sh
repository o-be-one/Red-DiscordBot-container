#!/bin/sh

if [ ! -f "/home/redbot/.config/config.json" ]; then
    echo "Initialising Red-DiscordBot..."
    redbot-setup \
        --backend json \
        --no-prompt \
        --instance-name "${REDBOT_NAME}"
fi

if [ -z "${REDBOT_TOKEN}" ]; then
    exec redbot "${REDBOT_NAME}" --no-prompt --prefix "${REDBOT_PREFIX}" --owner "${REDBOT_OWNER}" ${REDBOT_ARGS}
else
    exec redbot "${REDBOT_NAME}" --no-prompt --token "${REDBOT_TOKEN}" --prefix "${REDBOT_PREFIX}" --owner "${REDBOT_OWNER}" ${REDBOT_ARGS}
fi

