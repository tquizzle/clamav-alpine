FROM alpine:3.16
LABEL maintainer="https://github.com/tquizzle"

RUN apk update && apk add --no-cache pv ca-certificates clamav=0.104.3-r0 clamav-libunrar && apk add --upgrade apk-tools libcurl openssl busybox && rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
