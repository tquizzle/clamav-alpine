FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4
LABEL maintainer="Travis Quinnelly"
LABEL maintainer_url="https://github.com/tquizzle/"
LABEL clamav_version="1.4.5-r0"

RUN apk update && \
    apk add --no-cache pv ca-certificates clamav clamav-libunrar tzdata && \
    apk add --upgrade apk-tools libcurl openssl busybox && \
    rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
COPY clamd.conf /etc/clamav/clamd.conf
# freshclam.conf is the Alpine default with DatabaseOwner set to root
# so freshclam can write to mounted volumes regardless of host UID/GID.
# Sourced via: docker run --rm alpine:3.23 sh -c "apk add -q clamav && cat /etc/clamav/freshclam.conf"
COPY freshclam.conf /etc/clamav/freshclam.conf

ENTRYPOINT ["sh", "/scan.sh"]
