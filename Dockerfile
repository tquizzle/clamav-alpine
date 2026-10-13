FROM alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6
LABEL maintainer="Travis Quinnelly"
LABEL maintainer_url="https://github.com/tquizzle/"
LABEL clamav_version="1.4.6-r0"

RUN apk update && \
    apk add --no-cache pv ca-certificates clamav clamav-libunrar tzdata && \
    apk add --no-cache --upgrade apk-tools libcurl openssl busybox && \
    rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
COPY clamd.conf /etc/clamav/clamd.conf
# freshclam.conf is the Alpine default with DatabaseOwner set to root
# so freshclam can write to mounted volumes regardless of host UID/GID.
# Sourced via: docker run --rm alpine:3.23 sh -c "apk add -q clamav && cat /etc/clamav/freshclam.conf"
COPY freshclam.conf /etc/clamav/freshclam.conf

ENTRYPOINT ["sh", "/scan.sh"]
