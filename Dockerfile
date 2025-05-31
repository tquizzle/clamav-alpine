FROM alpine:3.22@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
LABEL maintainer="Travis Quinnelly"
LABEL maintainer_url="https://github.com/tquizzle/"
LABEL clamav_version="1.4.2-r0"

RUN apk update && \
    apk add --no-cache pv ca-certificates clamav clamav-libunrar tzdata && \
    apk add --upgrade apk-tools libcurl openssl busybox && \
    rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
COPY clamd.conf /etc/clamav/clamd.conf

ENTRYPOINT ["sh", "/scan.sh"]
