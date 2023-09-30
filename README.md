# ClamAV scanning Docker container based on Alpine
<img src="http://its.ucsc.edu/software/images/clam.png"> 

![Docker Pulls](https://img.shields.io/docker/pulls/tquinnelly/clamav-alpine.svg?style=for-the-badge) ![GitHub Build Status (with event)](https://img.shields.io/github/actions/workflow/status/tquizzle/clamav-alpine/.github%2Fworkflows%2Fdocker-cicd.yml?style=for-the-badge)
 [<img src="https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&color=086DA5&logoColor=white">](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FMYAA6ZDFC4BE&source=url) 

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
      - [2023-09-30](#2023-09-30)
      - [2023-07](#2023-07)
      - [2023-05-27](#2023-05-27)
      - [2023-05-26](#2023-05-26)
      - [2023-04-23](#2023-04-23)
      - [2023-04-22](#2023-04-22)
      - [2023-02-11](#2023-02-11)
      - [2022-09-02](#2022-09-02)
      - [2022-07-10](#2022-07-10)
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
# docker run -it -v /path:/scan:ro tquinnelly/clamav-alpine -i

2022-07-10T13:05:10+00:00 ClamAV process starting

Updating ClamAV scan DB
ClamAV update process started at Sun Jul 10 13:05:10 2022
daily database available for download (remote version: 26597)
Testing database: '/var/lib/clamav/tmp.c94c177031/clamav-5960cb40f091d042fdbe87b6656dc482.tmp-daily.cvd' ...
Database test passed.
daily.cvd updated (version: 26597, sigs: 1989376, f-level: 90, builder: raynman)
main database available for download (remote version: 62)
Testing database: '/var/lib/clamav/tmp.c94c177031/clamav-f97772d5bbd6c13c61c4ea14c3ebeb86.tmp-main.cvd' ...
Database test passed.
main.cvd updated (version: 62, sigs: 6647427, f-level: 90, builder: sigmgr)
bytecode database available for download (remote version: 333)
Testing database: '/var/lib/clamav/tmp.c94c177031/clamav-5ce3fe7b3dd82e9d6f61c4d68dde2ab0.tmp-bytecode.cvd' ...
Database test passed.
bytecode.cvd updated (version: 333, sigs: 92, f-level: 63, builder: awillia2)

Freshclam updated the DB

ClamAV 0.104.3/26597/Sun Jul 10 07:56:43 2022

Scanning /scan

----------- SCAN SUMMARY -----------
Known viruses: 8621438
Engine version: 0.104.3
Scanned directories: 3171
Scanned files: 16683
Infected files: 0
Data scanned: 3131.81 MB
Data read: 3120.78 MB (ratio 1.00:1)
Time: 375.514 sec (6 m 15 s)
Start Date: 2022:07:10 13:05:53
End Date:   2022:07:10 13:12:08

2022-07-10T13:12:08+00:00 ClamAV scanning finished
```

## Supported Tags | Versions

| Tag | ClamAV Version | Alpine Version |
| --- | --- | --- |
| latest | 1.1.2-r0 | 3 |
| edge | 1.2.0-r1 | Edge |

<!-- ## Vuln Scanning
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
* Base image:        alpine:3.16.0

✔ Tested 39 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image -->

## History

#### [2023-09-30](#2023-09-30) 
* Updated ClamAV to `1.1.2-r0` on `latest`
* CVE Squash
  * [CVE-2022-48174⁠](https://nvd.nist.gov/vuln/detail/CVE-2022-48174) 9.8
  * [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817) 5.3
  * [CVE-2023-2975](https://nvd.nist.gov/vuln/detail/CVE-2023-2975) 5.3
  * [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650) 6.5
* Updated ClamAV to `1.2.0-r1` on `edge`

#### [2023-07](#2023-07) 
* Added `tzdata` for local timezone data

#### [2023-05-27](#2023-05-27) 
* Updated `scan.sh` to fix the new line issue
* Updated `edge` and `latest` Dockerfiles to remove hardcoded ClamAV version

#### [2023-05-26](#2023-05-26) 
* Updated `latest` to Alpine 3.18
* Updated ClamAV to 1.10-r0 on `latest` and `edge`

#### [2023-04-23](#2023-04-23)
* Updated ClamAV to 1.0.1-r0 on `edge`

#### [2023-04-22](#2023-04-22)
* Updated ClamAV to 0.105.2-r0 on `latest`

#### [2023-02-11](#2023-02-11)
* Updated `latest` to Alpine 3.17
* Updated ClamAV to 0.105.1-r0

#### [2022-09-02](#2022-09-02)
* Updated ClamAV to 0.104.4-r1 on `edge`

#### [2022-07-10](#2022-07-10)
* Updating `latest` to Alpine 3.16
* Updating ClamAV to 0.104.3-r0 on `latest` and `edge`

#### [2021-12-24](#2021-12-24)
* Updating packages for vuln scan
* Reorganizing commands

#### [2021-11-25](#2021-11-25)
* Bump edge version for clamav to 0.104.1-r0

#### [2021-10-08](#2021-10-08)
* Bump edge version for clamav to 0.103.3-r1

#### [2021-06-24](#2021-06-24)
* Bump version for clamav 0.103.3-r0

#### [2021-04-17](#2021-04-17)
* Bump version for clamav 0.103.2-r0
* Pull Requests
  * Added Upgrade openssl
    * PR - https://github.com/tquizzle/clamav-alpine/pull/5
  * Added ca-certificates package
    * PR - https://github.com/tquizzle/clamav-alpine/pull/6

#### [2021-01-31](#2021-01-31)
* Bump version for clamav 0.103.0-r1

#### [2020-10-06](#2020-10-06)
* Bump version for clamav 0.102.4-r1

#### [2020-05-23](#2020-05-23)
* Bump version for clamav 0.102.3-r0
* Added unrar and unrar libs


#### [2020-02-16](#2020-02-16)
* Bump version for clamav 0.102.1-r0
