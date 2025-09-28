FROM alpine:3.20

RUN apk add --no-cache curl

ENV SERVICE=http-probe \
    CONFIG_FILE=/etc/probe/targets.conf \
    INTERVAL_SECONDS=10 \
    TIMEOUT_SECONDS=5

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY targets.conf /etc/probe/targets.conf

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

