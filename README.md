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

2020-06-02T22:09:19+0000 ClamAV process starting

Updating ClamAV scan DB
ClamAV update process started at Tue Jun  2 22:09:19 2020
daily database available for download (remote version: 25831)
Time: 2.7s, ETA: 0.0s [=============================>] 64.82MiB/64.82MiB
Testing database: '/var/lib/clamav/tmp.fa56e/clamav-0d94c6b7b3fa3b6c9def7e4670fe2764.tmp-daily.cvd' ...
Database test passed.
daily.cvd updated (version: 25831, sigs: 2582185, f-level: 63, builder: raynman)
main database available for download (remote version: 59)
Time: 4.9s, ETA: 0.0s [=============================>] 112.40MiB/112.40MiB
Testing database: '/var/lib/clamav/tmp.fa56e/clamav-bb7d37eedd3e36621c27529d52aef525.tmp-main.cvd' ...
Database test passed.
main.cvd updated (version: 59, sigs: 4564902, f-level: 60, builder: sigmgr)
bytecode database available for download (remote version: 331)
Time: 0.1s, ETA: 0.0s [=============================>] 289.44KiB/289.44KiB
Testing database: '/var/lib/clamav/tmp.fa56e/clamav-12bd5de6505f5289d66d4bbd68f82737.tmp-bytecode.cvd' ...
Database test passed.
bytecode.cvd updated (version: 331, sigs: 94, f-level: 63, builder: anvilleg)
WARNING: Clamd was NOT notified: Can't connect to clamd through /run/clamav/clamd.sock: No such file or directory


Freshclam updated the DB


ClamAV 0.102.3/25831/Tue Jun  2 12:41:03 2020

Scanning /scan


----------- SCAN SUMMARY -----------
Known viruses: 7136236
Engine version: 0.102.3
Scanned directories: 1
Scanned files: 1
Infected files: 0
Data scanned: 0.00 MB
Data read: 0.00 MB (ratio 0.00:1)
Time: 26.493 sec (0 m 26 s)

2020-06-02T22:10:17+0000 ClamAV scanning finished
```

### History

#### 2020-05-23

* Bump version for clamav 0.102.3-r0
* Added unrar and unrar libs

#### 2020-02-16

* Bump version for clamav 0.102.1-r0
