FROM alpine:latest
LABEL maintainer="Travis Quinnelly <tquinnelly@gmail.com>"

RUN apk update && apk add clamav=0.102.4-r1 clamav-libunrar unrar

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
