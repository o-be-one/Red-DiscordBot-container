#!/bin/sh

if [ ! -f "/home/redbot/.config/config.json" ]; then
    echo "Initialising Red-DiscordBot..."
    redbot-setup \
        --backend json \
        --no-prompt \
        --instance-name "${REDBOT_NAME}"
fi

exec redbot "${REDBOT_NAME}" --no-prompt --token "${REDBOT_TOKEN}" --prefix "${REDBOT_PREFIX}" --owner "${REDBOT_OWNER}" "$@"
