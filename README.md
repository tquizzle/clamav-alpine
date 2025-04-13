# ClamAV scanning Docker container based on Alpine

<img src="https://github.com/tquizzle/clamav-alpine/blob/master/img/clamav.png" width=300 alt="ClamAV"> 

# Usage

Documentation is available at its [own site](https://tquizzle.github.io/clamav-alpine/).

Some examples are below.

## Local scan

```sh
docker run --rm -e MODE=scan -v "$PWD/test_dir:/scan" clamav
```

or

```sh
docker run --rm -v "$PWD/test_dir:/scan" clamav
```

## Server

### Start server
Starting a default server instance:

```sh
docker run --rm -e MODE=server -p 3310:3310 clamav
```

Setting custom port and address:

```sh
docker run --rm -e MODE=server -e CLAMD_TCP_ADDR=10.17.2.1 -e CLAMD_TCP_PORT=3311 -p 3311:3311 clamav
```

### Usage on client

Point `clamdscan` on client to server socket:

```sh
mthompkins@picontent:~ $ cat /etc/clamav/remote-clamd.conf
TCPSocket 3310
TCPAddr 193.169.1.2
```

Run `clamdscan` on client:

```sh
$ clamdscan --config-file=/etc/clamav/remote-clamd.conf /path/to/scan
```
