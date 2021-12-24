FROM alpine:edge
LABEL maintainer="https://github.com/tquizzle"

RUN apk update && apk add --no-cache pv clamav=0.104.1-r0 clamav-libunrar ca-certificates && apk add --upgrade openssl apk-tools busybox
ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]