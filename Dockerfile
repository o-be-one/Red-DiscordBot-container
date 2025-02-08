FROM python:3.11-slim AS builder

RUN addgroup --gid 1000 redbot && \
    adduser --disabled-password --gecos "" --uid 1000 --gid 1000 redbot

WORKDIR /redbot
USER redbot
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11-slim

LABEL org.opencontainers.image.description "Red DiscordBot in a container."

COPY --from=builder /home/redbot/.local /home/redbot/.local
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --chown=redbot:redbot entrypoint.sh /entrypoint.sh

ENV PATH="/home/redbot/.local/bin:${PATH}" \
    REDBOT_NAME="mybot" \
    REDBOT_PREFIX="!" \
    REDBOT_OWNER=""

WORKDIR /home/redbot/.config
RUN chmod +x /entrypoint.sh && \
    chown -R redbot: /home/redbot

USER redbot

VOLUME /home/redbot/.config

ENTRYPOINT ["/entrypoint.sh"]
