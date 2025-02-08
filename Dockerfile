FROM python:3.11-slim AS builder

RUN addgroup --gid 1000 redbot && \
    adduser --disabled-password --gecos "" --uid 1000 --gid 1000 redbot

WORKDIR /home/redbot
USER redbot
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11-slim

LABEL org.opencontainers.image.description="Red DiscordBot in a container."

COPY --from=builder /home/redbot/.local /usr/local/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --chown=1000:1000 entrypoint.sh /entrypoint.sh

ENV REDBOT_NAME="mybot" \
    REDBOT_PREFIX="!" \
    REDBOT_OWNER=""

WORKDIR /home/redbot/
RUN chmod +x /entrypoint.sh && \
    chown -R 1000:1000 /home/redbot

USER 1000

VOLUME /home/redbot/

ENTRYPOINT ["/entrypoint.sh"]
