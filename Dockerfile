FROM alpine:3
LABEL maintainer="Travis Quinnelly" maintainer_url="https://github.com/tquizzle/"

RUN apk update && \
apk add --no-cache pv ca-certificates clamav=0.105.2-r0 clamav-libunrar && \
apk add --upgrade apk-tools libcurl openssl busybox && \
rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]