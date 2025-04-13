# ClamAV scanning Docker container based on Alpine
<img src="https://github.com/tquizzle/clamav-alpine/blob/master/img/clamav.png" width=300 alt="ClamAV"> 

Documentation is available at its [own site](https://tquizzle.github.io/clamav-alpine/).

<img src="https://tianji.0hq.cc/telemetry/clnzoxcy10001vy2ohi4obbi0/cm09ricjj0069kl2u25b2mi8m.gif" alt="ClamAV">

# Usage Example

Scanning locally:

```sh
docker run --rm -e MODE=scan -v "$PWD/test_dir:/scan" clamav
```

or

```sh
docker run --rm -v "$PWD/test_dir:/scan" clamav
```

Starting a default server instance:

```sh
docker run --rm -e MODE=server -p 3310:3310 clamav
```

Setting custom port and address:

```sh
docker run --rm -e MODE=server -e CLAMD_TCP_ADDR=10.17.2.1 -e CLAMD_TCP_PORT=3311 -p 3311:3311 clamav
```
