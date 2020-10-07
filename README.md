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
ClamAV update process started at Wed Oct  7 04:04:27 2020
daily database available for download (remote version: 25949)
Time: 1.6s, ETA: 0.0s [=============================>] 108.12MiB/108.12MiB
Testing database: '/var/lib/clamav/tmp.bbcc2/clamav-9328d8ee72166612b0ff7745f1871812.tmp-daily.cvd
Database test passed.
daily.cvd updated (version: 25949, sigs: 4328154, f-level: 63, builder: raynman)
main database available for download (remote version: 59)
Time: 1.6s, ETA: 0.0s [=============================>] 112.40MiB/112.40MiB
Testing database: '/var/lib/clamav/tmp.bbcc2/clamav-3533f1ff9c0acba3c5c80169c8db1bc9.tmp-main.cvd'
Database test passed.
main.cvd updated (version: 59, sigs: 4564902, f-level: 60, builder: sigmgr)
bytecode database available for download (remote version: 331)
Time: 0.1s, ETA: 0.0s [=============================>] 289.44KiB/289.44KiB
Testing database: '/var/lib/clamav/tmp.bbcc2/clamav-746c265d927ae6cf9a1c3103cee74c51.tmp-bytecode.
Database test passed.
bytecode.cvd updated (version: 331, sigs: 94, f-level: 63, builder: anvilleg)
WARNING: Clamd was NOT notified: Can't connect to clamd through /run/clamav/clamd.sock: No such fi


Freshclam updated the DB


ClamAV 0.102.4/25949/Tue Oct  6 13:58:16 2020


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

2020-10-07T04:05:32+0000 ClamAV scanning finished
```

### History

#### 2020-10-06

* Bump version for clamav 0.102.4-r1

#### 2020-05-23

* Bump version for clamav 0.102.3-r0
* Added unrar and unrar libs

#### 2020-02-16

* Bump version for clamav 0.102.1-r0
