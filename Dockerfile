FROM alpine:3.13
LABEL maintainer="Travis Quinnelly"

RUN apk update && apk add pv clamav=0.103.1-r0 clamav-libunrar unrar && apk add --upgrade openssl && apk add --no-cache ca-certificates

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
