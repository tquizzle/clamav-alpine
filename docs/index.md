---
title: "ClamAV scanning Docker container based on Alpine"
description: "This container allows you a very simple way to scan a mounted directory using clamscan."
---

# ClamAV scanning Docker container based on Alpine

![Docker Pulls](https://flat.badgen.net/docker/pulls/tquinnelly/clamav-alpine) ![Docker Image Size](https://flat.badgen.net/docker/size/tquinnelly/clamav-alpine) ![Docker Stars](https://flat.badgen.net/docker/stars/tquinnelly/clamav-alpine)

![Last Commit](https://flat.badgen.net/github/last-commit/tquizzle/clamav-alpine)

[<img src="https://raw.githubusercontent.com/tquizzle/clamav-alpine/master/img/kofi_long_button_red-402x500.png" width=225 />](https://ko-fi.com/tquinnelly)

---

This container allows you a very simple way to scan a mounted directory using `clamscan`.

It will always update the ClamAV Database, by using the standard `freshclam` before running `clamscan`.
If the local ClamAV Database is up-to-date, it will check and continue.

Thanks to @MitchellThompkins, we have "modes" to run in now.
You can simply switch the mode and instead of just the scan feature, you can run SERVER mode to enable another, perhaps small PC, have itself scanned by the SERVER.

## How-To

### Usage

#### Local Scan Mode
This is your typical behavior that we all know and love.

```
docker run --rm -e MODE=scan -v "$PWD/test_dir:/scan" tquinnelly/clamav-alpine
```

**Note: The default still works as scan mode.**

#### Server Mode
Starting a server instance:

```
docker run --rm -e MODE=server -p 3310:3310 tquinnelly/clamav-alpine
```

Setting custom port and address:

```
docker run --rm -e MODE=server -e CLAMD_TCP_ADDR=10.17.2.1 -e CLAMD_TCP_PORT=3311 -p 3311:3311 tquinnelly/clamav-alpine
```


#### Client Usage

Ensure that `clamdscan` is installed on your Linux server.
Point `clamdscan` on client to server socket:

```
cat << 'EOF' > /etc/clamav/remote-clamd.conf
TCPSocket PORT
TCPAddr SERVER-IP
EOF
```

Run clamdscan on client:

```
clamdscan --config-file=/etc/clamav/remote-clamd.conf /path/to/scan
```

#### Standard Usage 
Again, this is the same as running in scan mode.

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

## Supported Tags | Versions

| Tag | ClamAV Version | Alpine Version |
| --- | --- | --- |
| latest | 1.4.2-r0 | 3.21 |
| edge | 1.4.2-r0 | Edge |


## Changelog

### [2025-04-15](#2025-04-15)
* Added support for server mode as well as scan mode.
  * Hat tip [@MitchellThompkins](https://github.com/MitchellThompkins)

### [2025-02-25](#2025-02-25)
* Updated ClamAV to 1.4.2-r0 on `latest` and `edge`

### [2024-12-23](#2024-12-23)
* Updated Alpine to 3.21 `latest`
* Updated ClamAV to 1.4.1-r0 on `latest`

### [2024-12-03](#2024-12-03)
* Updated ClamAV to 1.4.1-r0 on `edge`

### [2024-09-15](#2024-09-15)
* Updated Alpine to 3.20.3 `latest`
* Updated ClamAV to 1.3.2-r0 on `edge`

### [2024-03-08](#2024-03-08)
* Updated ClamAV to 1.2.2-r0 on `latest` and `edge`

### [2024-01-14](#2024-01-14)
* Updated openssl to 3.1.4-r3 on `latest` and `edge` to mitigate [CVE-2023-6129](https://security.snyk.io/vuln/SNYK-ALPINE319-OPENSSL-6148881)

### [2023-12-09](#2023-12-09)
* Updated ClamAV to 1.2.1-r0 on `latest` and `edge`

### [2023-05-27](#2023-05-27) 
* Updated `scan.sh` to fix the new line issue
* Updated `edge` and `latest` Dockerfiles to remove hardcoded ClamAV version

### [2023-05-26](#2023-05-26) 
* Updated `latest` to Alpine 3.18
* Updated ClamAV to 1.10-r0 on `latest` and `edge`

### [2023-04-23](#2023-04-23)
* Updated ClamAV to 1.0.1-r0 on `edge`

### [2023-04-22](#2023-04-22)
* Updated ClamAV to 0.105.2-r0 on `latest`

### [2023-02-11](#2023-02-11)
* Updated `latest` to Alpine 3.17
* Updated ClamAV to 0.105.1-r0

### [2022-09-02](#2022-09-02)
* Updated ClamAV to 0.104.4-r1 on `edge`

### [2022-07-10](#2022-07-10)
* Updating `latest` to Alpine 3.16
* Updating ClamAV to 0.104.3-r0 on `latest` and `edge`

### [2021-12-24](#2021-12-24)
* Updating packages for vuln scan
* Reorganizing commands

### [2021-11-25](#2021-11-25)
* Bump edge version for clamav to 0.104.1-r0

### [2021-10-08](#2021-10-08)
* Bump edge version for clamav to 0.103.3-r1

### [2021-06-24](#2021-06-24)
* Bump version for clamav 0.103.3-r0

### [2021-04-17](#2021-04-17)
* Bump version for clamav 0.103.2-r0
* Pull Requests
  * Added Upgrade openssl
    * PR - https://github.com/tquizzle/clamav-alpine/pull/5
  * Added ca-certificates package
    * PR - https://github.com/tquizzle/clamav-alpine/pull/6

### [2021-01-31](#2021-01-31)
* Bump version for clamav 0.103.0-r1

### [2020-10-06](#2020-10-06)
* Bump version for clamav 0.102.4-r1

### [2020-05-23](#2020-05-23)
* Bump version for clamav 0.102.3-r0
* Added unrar and unrar libs


### [2020-02-16](#2020-02-16)
* Bump version for clamav 0.102.1-r0


![tianji](https://tianji.tq.network/telemetry/clnzoxcy10001vy2ohi4obbi0/cma9opvvv10nqmitpg2ogqn80.gif)
