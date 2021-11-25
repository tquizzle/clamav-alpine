FROM alpine:edge
LABEL maintainer="https://github.com/tquizzle"

RUN apk update && apk add clamav=0.104.1-r0 clamav-libunrar && apk add --upgrade openssl && apk add --no-cache ca-certificates

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
