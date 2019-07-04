FROM alpine:latest
LABEL maintainer="Travis Quinnelly <tquinnelly@gmail.com>"

RUN apk add clamav

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]