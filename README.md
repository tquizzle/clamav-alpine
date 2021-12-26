# ClamAV scanning Docker container based on Alpine
<img src="http://its.ucsc.edu/software/images/clam.png">

<!-- ![Docker Pulls](https://img.shields.io/docker/pulls/tquinnelly/clamav-alpine.svg?style=for-the-badge) -->
![Downloads](https://img.shields.io/github/downloads/tquinnelly/clamav-alpine/total.svg)

[<img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white">](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FMYAA6ZDFC4BE&source=url)

<!-- TOC -->
- [ClamAV scanning Docker container based on Alpine](#clamav-scanning-docker-container-based-on-alpine)
  - [How-To](#how-to)
    - [Usage](#usage)
      - [Post-Args](#post-args)
      - [Volumes](#volumes)
    - [Examples](#examples)
  - [Expected Output](#expected-output)
  - [Supported Tags | Versions](#supported-tags--versions)
  - [Vuln Scanning](#vuln-scanning)
    - [Edge](#edge)
    - [Latest](#latest)
  - [History](#history)
      - [2021-12-24](#2021-12-24)
      - [2021-11-25](#2021-11-25)
      - [2021-10-08](#2021-10-08)
      - [2021-06-24](#2021-06-24)
      - [2021-04-17](#2021-04-17)
      - [2021-01-31](#2021-01-31)
      - [2020-10-06](#2020-10-06)
      - [2020-05-23](#2020-05-23)
      - [2020-02-16](#2020-02-16)
<!-- /TOC -->

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
#### Post-Args
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
* `--nocerts` - disable authenticode certificate chain verification in PE files
* `--disable-cache` - disable caching and cache checks for hash sums of scanned files

#### Volumes
I only have the `/scan` directory noted above. You can add others in conjunction with the post-args as well.

**Save AV Signatures**

* `-v /path/to/sig:/var/lib/clamav`

**Infected Dir**

* `-v /path/to/infected:/infected`
* Then  you can use either the `--move` or `--copy` post-arg above.

### Examples
Here are some examples of various configurations.

This is the one **I** run. I target 2 cores of my CPU as to not cripple my host. I also log to the DB directory and limit 2G file size scan.

```
docker run -d --name=ClamAV \
  --cpuset-cpus='0,1' \
  -v /path/to/scan:/scan:ro \
  -v /path/to/sig:/var/lib/clamav:rw \
  tquinnelly/clamav-alpine -i --log=/var/lib/clamav/log.log --max-filesize=2048M
```

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

## Supported Tags | Versions

| Tag | ClamAV Version | Alpine Version |
| --- | --- | --- |
| latest | 0.103.3-r0 | 3.14 |
| edge | 0.104.1-r0 | Edge |

## Vuln Scanning
### Edge
Testing tquinnelly/clamav-alpine:edge...

* Package manager:   apk
* Project name:      docker-image|tquinnelly/clamav-alpine
* Docker image:      tquinnelly/clamav-alpine:edge
* Platform:          linux/amd64

✔ Tested 39 dependencies for known vulnerabilities, no vulnerable paths found.

### Latest
Testing tquinnelly/clamav-alpine...

* Package manager:   apk
* Project name:      docker-image|tquinnelly/clamav-alpine
* Docker image:      tquinnelly/clamav-alpine
* Platform:          linux/amd64
* Base image:        alpine:3.14.3

✔ Tested 37 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image

## History

#### 2021-12-24
* Updating packages for vuln scan
* Reorganizing commands

#### 2021-11-25
* Bump edge version for clamav to 0.104.1-r0

#### 2021-10-08
* Bump edge version for clamav to 0.103.3-r1

#### 2021-06-24
* Bump version for clamav 0.103.3-r0

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
