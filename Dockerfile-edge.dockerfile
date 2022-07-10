FROM alpine:edge
LABEL maintainer="https://github.com/tquizzle"

RUN apk update && apk add --no-cache pv clamav=0.104.3-r0 clamav-libunrar ca-certificates && apk add --upgrade openssl apk-tools busybox && rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]