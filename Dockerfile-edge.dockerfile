FROM alpine:edge
LABEL maintainer="Travis Quinnelly" 
LABEL maintainer_url="https://github.com/tquizzle/"

RUN apk update && \
    apk add --no-cache pv clamav clamav-libunrar ca-certificates tzdata && \
    apk add --upgrade openssl apk-tools busybox && \
    rm -rf /var/cache/apk/*

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]