---
title: "ClamAV on Alpine"
description: "This container allows you a very simple way to scan a mounted directory using clamscan."
---
# ClamAV on Alpine: Your Lightweight Container for Virus Scanning 🛡️

-----

This Docker container offers a straightforward and efficient way to perform virus scans using **ClamAV**, built on the incredibly lightweight **Alpine Linux**. It's perfect for quickly scanning mounted directories or setting up a dedicated ClamAV server or client.

![Docker Pulls](https://flat.badgen.net/docker/pulls/tquinnelly/clamav-alpine) ![Docker Image Size](https://flat.badgen.net/docker/size/tquinnelly/clamav-alpine) ![Docker Stars](https://flat.badgen.net/docker/stars/tquinnelly/clamav-alpine) ![Github Stars](https://flat.badgen.net/github/stars/tquizzle/clamav-alpine) ![GitHub Issues](https://flat.badgen.net/github/issues/tquizzle/clamav-alpine) ![GitHub Contributors](https://flat.badgen.net/github/contributors/tquizzle/clamav-alpine) ![Last Commit](https://flat.badgen.net/github/last-commit/tquizzle/clamav-alpine)

[<img src="https://raw.githubusercontent.com/tquizzle/clamav-alpine/master/img/kofi_long_button_red-402x500.png" width=225 />](https://ko-fi.com/tquinnelly)

-----
## Key Features ✨

  * **Always Up-to-Date:** Automatically updates the ClamAV database using `freshclam` before every scan, ensuring you have the latest threat definitions.
  * **Flexible Modes:** Choose between **Scan Mode** for direct directory scanning or **Server Mode** to enable network-based scanning for other clients. (Thanks, @MitchellThompkins\!)
  * **Lightweight & Fast:** Built on Alpine Linux, this container is designed for minimal overhead and quick operations.
  * **Customizable:** Supports various `clamscan` arguments and volume mounts for advanced configurations.

-----

## Getting Started 🚀

### Usage Modes

This container supports two primary modes of operation, controlled by the `MODE` environment variable.

#### 📁 Local Scan Mode (Default)

This is the classic way to use ClamAV: scan a mounted directory directly. If no `MODE` is specified, `scan` is the default.

```
docker run --rm -e MODE=scan -v "$PWD/test_dir:/scan" tquinnelly/clamav-alpine
```

#### 🌐 Server Mode

Run ClamAV as a daemon, allowing other clients to connect and request scans.

```
docker run --rm -e MODE=server -p 3310:3310 tquinnelly/clamav-alpine
```

**Custom Port and Address:**

```
docker run --rm -e MODE=server -e CLAMD_TCP_ADDR=10.17.2.1 -e CLAMD_TCP_PORT=3311 -p 3311:3311 tquinnelly/clamav-alpine
```

### Client Usage (with Server Mode)

If you're running the container in Server Mode, you can configure `clamdscan` on your client machines to connect to it.

1.  **Install `clamdscan`:**
    Ensure `clamdscan` is installed on your Linux client.

2.  **Configure `clamdscan`:**
    Create a configuration file to point to your ClamAV server:

    ```
    cat << 'EOF' | sudo tee /etc/clamav/remote-clamd.conf
    TCPSocket PORT
    TCPAddr SERVER-IP
    EOF
    ```

      * Replace `PORT` with your server's ClamAV port (e.g., `3310`).
      * Replace `SERVER-IP` with the IP address of your ClamAV server container.

3.  **Run `clamdscan`:**
    Execute a scan on the client, specifying the remote configuration:

    ```
    clamdscan --config-file=/etc/clamav/remote-clamd.conf /path/to/scan
    ```

### Standard Scan Options

For more control over your scans, you can pass additional `clamscan` arguments directly to the container. The `-i` flag (only print infected files) is included by default, but you can override or add to it.

```
docker run -it \
  -v /path/to/scan:/scan:ro \
  tquinnelly/clamav-alpine -i
```

Use `-d` instead of `-it` if you prefer to run the scan in detached mode.

#### Common `clamscan` Post-Arguments

You can append any of these arguments to your `docker run` command for scan customization:

  * `-i`: **Only print infected files** (default behavior).
  * `--log=FILE`: Save the scan report to a specified `FILE`.
  * `--database=FILE/DIR`: Load the virus database from a specific `FILE` or all supported database files from a `DIR`.
  * `--max-filesize=#n`: Skip files larger than `#n` bytes and assume them clean.
  * `--max-scansize=#n`: Set the maximum amount of data to scan for each container file.
  * `--move=DIRECTORY`: Move infected files to `DIRECTORY`.
  * `--copy=DIRECTORY`: Copy infected files to `DIRECTORY`.
  * `--bytecode-timeout=N`: Set the bytecode timeout in milliseconds.
  * `--cross-fs`: Scan files and directories across different filesystems (default: enabled).
  * `--heuristic-alerts`: Toggle heuristic alerts (default: enabled).
  * `--alert-encrypted`: Alert on encrypted archives and documents (default: disabled).
  * `--quiet`: Suppress all output except error messages.
  * `--bell`: Sound a bell upon virus detection.
  * `--disable-cache`: Disable caching and cache checks for hash sums of scanned files.

### Volume Mounts 💾

Beyond the primary `/scan` directory, you can mount additional volumes for enhanced functionality.

  * **Save AV Signatures:** Persist your ClamAV database updates to avoid re-downloading them on every container start.

    ```
    -v /path/to/sig:/var/lib/clamav
    ```

  * **Infected Files Directory:** Direct infected files to a specific location using `--move` or `--copy` post-arguments.

    ```
    -v /path/to/infected:/infected
    ```

-----

## Examples 💡

Here's an example of a more advanced setup, typical for a persistent ClamAV scanner:

```
docker run -d --name=ClamAV \
  --cpuset-cpus='0,1' \
  -v /path/to/scan:/scan:ro \
  -v /path/to/sig:/var/lib/clamav:rw \
  tquinnelly/clamav-alpine -i --log=/var/lib/clamav/log.log --max-filesize=2048M
```

This command:

  * Runs the container in **detached mode** (`-d`) and names it `ClamAV`.
  * **Limits CPU usage** to cores 0 and 1.
  * **Mounts** `/path/to/scan` as a **read-only** directory inside the container for scanning.
  * **Mounts** `/path/to/sig` for **persistent storage of ClamAV signatures** and logs.
  * Instructs `clamscan` to **only print infected files** (`-i`).
  * **Logs scan reports** to `/var/lib/clamav/log.log`.
  * **Skips files larger than 2GB** (`--max-filesize=2048M`).

-----

## Supported Tags & Versions 🏷️

| Tag      | ClamAV Version | Alpine Version |
| :------- | :------------- | :------------- |
| `latest` | 1.4.3-r2       | 3.23           |
| `edge`   | 1.4.3-r2       | Edge           |

-----

## Changelog 📜


### 2025-12-11

  * Updated ClamAV to **1.4.3-r2** on the `latest` tag.

### 2025-10-28

  * Updated ClamAV to **1.4.3-r2** on the `edge` tag.
  * Updated ClamAV to **1.4.3-r0** on the `latest` tag.

### 2025-04-15

  * Added support for **server mode** as well as scan mode.
      * Big thanks to [@MitchellThompkins](https://github.com/MitchellThompkins) for this contribution\!

### 2025-02-25

  * Updated ClamAV to **1.4.2-r0** on `latest` and `edge` tags.

### 2024-12-23

  * Updated Alpine to **3.21** for the `latest` tag.
  * Updated ClamAV to **1.4.1-r0** on the `latest` tag.

### 2024-12-03

  * Updated ClamAV to **1.4.1-r0** on the `edge` tag.

### 2024-09-15

  * Updated Alpine to **3.20.3** for the `latest` tag.
  * Updated ClamAV to **1.3.2-r0** on the `edge` tag.

### 2024-03-08

  * Updated ClamAV to **1.2.2-r0** on `latest` and `edge` tags.

### 2024-01-14

  * Updated `openssl` to **3.1.4-r3** on `latest` and `edge` to mitigate [CVE-2023-6129](https://security.snyk.io/vuln/SNYK-ALPINE319-OPENSSL-6148881).

### 2023-12-09

  * Updated ClamAV to **1.2.1-r0** on `latest` and `edge` tags.

### 2023-05-27

  * Fixed a new line issue in `scan.sh`.
  * Removed hardcoded ClamAV version from `edge` and `latest` Dockerfiles.

### 2023-05-26

  * Updated `latest` to **Alpine 3.18**.
  * Updated ClamAV to **1.10-r0** on `latest` and `edge` tags.

### 2023-04-23

  * Updated ClamAV to **1.0.1-r0** on the `edge` tag.

### 2023-04-22

  * Updated ClamAV to **0.105.2-r0** on the `latest` tag.

### 2023-02-11

  * Updated `latest` to **Alpine 3.17**.
  * Updated ClamAV to **0.105.1-r0**.

### 2022-09-02

  * Updated ClamAV to **0.104.4-r1** on the `edge` tag.

### 2022-07-10

  * Updated `latest` to **Alpine 3.16**.
  * Updated ClamAV to **0.104.3-r0** on `latest` and `edge` tags.

### 2021-12-24

  * Updated packages for vulnerability scanning.
  * Reorganized commands.

### 2021-11-25

  * Bumped `edge` version for ClamAV to **0.104.1-r0**.

### 2021-10-08

  * Bumped `edge` version for ClamAV to **0.103.3-r1**.

### 2021-06-24

  * Bumped version for ClamAV to **0.103.3-r0**.

### 2021-04-17

  * Bumped version for ClamAV to **0.103.2-r0**.
  * **Pull Requests:**
      * Added Upgrade `openssl` ([PR \#5](https://github.com/tquizzle/clamav-alpine/pull/5)).
      * Added `ca-certificates` package ([PR \#6](https://github.com/tquizzle/clamav-alpine/pull/6)).

### 2021-01-31

  * Bumped version for ClamAV to **0.103.0-r1**.

### 2020-10-06

  * Bumped version for ClamAV to **0.102.4-r1**.

### 2020-05-23

  * Bumped version for ClamAV to **0.102.3-r0**.
  * Added `unrar` and `unrar libs`.

### 2020-02-16

  * Bumped version for ClamAV to **0.102.1-r0**.

-----

Have questions or suggestions? Feel free to open an issue or pull request.

![tianji](https://tianji.tq.network/telemetry/clnzoxcy10001vy2ohi4obbi0/cma9opvvv10nqmitpg2ogqn80.gif)
