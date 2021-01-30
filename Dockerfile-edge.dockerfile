FROM alpine:edge
LABEL maintainer="Travis Quinnelly <tquinnelly@gmail.com>"

RUN apk update && apk add clamav clamav-libunrar unrar

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
