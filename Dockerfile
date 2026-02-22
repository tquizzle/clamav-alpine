FROM alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659
LABEL maintainer="Travis Quinnelly"
LABEL maintainer_url="https://github.com/tquizzle/"
LABEL clamav_version="1.4.3-r2"

RUN apk update && \
    apk add --no-cache pv ca-certificates clamav clamav-libunrar tzdata && \
    apk add --upgrade apk-tools libcurl openssl busybox && \
    rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
COPY clamd.conf /etc/clamav/clamd.conf

ENTRYPOINT ["sh", "/scan.sh"]
