# ClamAV scanning Docker container based on Alpine

![Docker Pulls](https://img.shields.io/docker/pulls/tquinnelly/clamav-alpine.svg?style=for-the-badge)

!(https://img.shields.io/badge/PayPal-Docker%20Love-informational)

This container allows you a very simple way to scan a mounted directory using `clamscan`.

It will always update the ClamAV Database, by using the standard `freshclam` before running `clamscan`.
If the local ClamAV Database is up-to-date, it will check and continue.

## How-To
### Usage
Using this image is fairly straightforward.

Pay attention to `-v /path/to/scan` as this is the mounted directory that this docker image will scan.

```
docker run -it \
  -v /path/to/scan:/scan:ro \
  tquinnelly/clamav-alpine -i
```
Use `-d` instead of `-it` if you want to detach and move along.
### Post-Args
I took the liberty to include `-i` by default. You can, however, add any you desire.

* `-i` - Only print infected files
* `--log=FILE` - save scan report to FILE
* `--database=FILE/DIR` - load virus database from FILE or load all supported db files from DIR
* `--official-db-only[=yes/no(*)]` - only load official signatures
* `--max-filesize=#n` - files larger than this will be skipped and assumed clean
* `--max-scansize=#n` - the maximum amount of data to scan for each container file
* `--leave-temps[=yes/no(*)]`- do not remove temporary files
* `--file-list=FILE` - scan files from FILE
* `--quiet` - only output error messages
* `--bell` - sound bell on virus detection
* `--cross-fs[=yes(*)/no]` - scan files and directories on other filesystems
* `--move=DIRECTORY` - move infected files into DIRECTORY
* `--copy=DIRECTORY` - copy infected files into DIRECTORY
* `--bytecode-timeout=N` - set bytecode timeout (in milliseconds)
* `--heuristic-alerts[=yes(*)/no]` - toggles heuristic alerts
* `--alert-encrypted[=yes/no(*)]` - alert on encrypted archives and documents
* `--nocerts` - disable authenticode certificate chain verification in PE files`--disable-cache` - disable caching and cache checks for hash sums of scanned files

## Expected Output

```
# docker run -it -v /opt:/scan:ro tquinnelly/clamav-alpine -i

2021-04-17T20:20:56+0000 ClamAV process starting

Updating ClamAV scan DB
ClamAV update process started at Sat Apr 17 20:20:56 2021
daily.cld database is up-to-date (version: 26143, sigs: 3971196, f-level: 63, builder: raynman)
main.cld database is up-to-date (version: 59, sigs: 4564902, f-level: 60, builder: sigmgr)
bytecode.cld database is up-to-date (version: 333, sigs: 92, f-level: 63, builder: awillia2)


Freshclam updated the DB


ClamAV 0.103.2/26143/Sat Apr 17 11:06:39 2021

Scanning /scan

----------- SCAN SUMMARY -----------
Known viruses: 8520831
Engine version: 0.103.2
Scanned directories: 232
Scanned files: 5024
Infected files: 0
Data scanned: 53482.56 MB
Data read: 140471.02 MB (ratio 0.38:1)
Time: 5801.541 sec (96 m 41 s)
Start Date: 2021:04:17 20:20:56
End Date:   2021:04:17 21:57:37

2021-04-17T21:57:38+0000 ClamAV scanning finished
```

### History

#### 2021-04-17
* Bump version for clamav 0.103.2-r0
* Pull Requests
  * Added Upgrade openssl
    * PR - https://github.com/tquizzle/clamav-alpine/pull/5
  * Added ca-certificates package
    * PR - https://github.com/tquizzle/clamav-alpine/pull/6
#### 2021-01-31
* Bump version for clamav 0.103.0-r1

#### 2020-10-06

* Bump version for clamav 0.102.4-r1

#### 2020-05-23

* Bump version for clamav 0.102.3-r0
* Added unrar and unrar libs

#### 2020-02-16

* Bump version for clamav 0.102.1-r0
