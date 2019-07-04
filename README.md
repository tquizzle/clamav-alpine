# ClamAV scanning Docker container based on Alpine

![Docker Pulls](https://img.shields.io/docker/pulls/tquinnelly/clamav-alpine.svg?style=for-the-badge)

This container allows you a very simple way to scan a mounted directory using `clamscan`.

It will always update the ClamAV Database, by using the standard `freshclam` before running `clamscan`.
If the local ClamAV Database is up-to-date, it will check and continue.

## How-To
Using this image is fairly straightforward.

Pay attention to `-v /path/to/scan` as this is the mounted directory that this docker image will scan.

```
docker run -it \
  -v /path/to/scan:/scan:ro \
  tquinnelly/clamav-alpine -i
```

## Expected Output

```
# docker run -it -v /opt:/scan:ro tquinnelly/clamav-alpine -i

2019-07-04T14:06:49+0000 ClamAV scanning started

Updating ClamAV scan DB
ClamAV update process started at Thu Jul  4 14:06:49 2019
WARNING: Your ClamAV installation is OUTDATED!
WARNING: Local version: 0.100.3 Recommended version: 0.101.2
DON'T PANIC! Read https://www.clamav.net/documents/upgrading-clamav
Downloading main.cvd [100%]
main.cvd updated (version: 58, sigs: 4566249, f-level: 60, builder: sigmgr)
Downloading daily.cvd [100%]
daily.cvd updated (version: 25500, sigs: 1610180, f-level: 63, builder: raynman)
Downloading bytecode.cvd [100%]
bytecode.cvd updated (version: 328, sigs: 94, f-level: 63, builder: neo)
Database updated (6176523 signatures) from database.clamav.net (IP: 104.16.218.84)

Freshclam updated the DB

Scanning /scan

----------- SCAN SUMMARY -----------
Known viruses: 6167018
Engine version: 0.100.3
Scanned directories: 4
Scanned files: 4
Infected files: 0
Data scanned: 0.66 MB
Data read: 0.33 MB (ratio 2.00:1)
Time: 61.979 sec (1 m 1 s)

2019-07-04T14:08:59+0000 ClamAV scanning finished
```
