FROM alpine:edge
LABEL maintainer="Travis Quinnelly" maintainer_url="https://github.com/tquizzle/"

RUN apk update && apk add --no-cache pv clamav=1.0.1-r1 clamav-libunrar ca-certificates && apk add --upgrade openssl apk-tools busybox && rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]