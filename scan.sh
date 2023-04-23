#!/bin/bash
set -euo pipefail
echo "\n$( date -I'seconds' ) ClamAV process starting\n"
echo "\Unpdating ClamAV scan DB\n"
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo "\nFreshclam updated the DB\n"
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo "\nClamAV DB already up to date...\n"
else
    echo "\nAn error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT')\n"
    exit $FRESHCLAM_EXIT
fi
clamscan -V
echo "\nScanning $SCANDIR"
clamscan -r $SCANDIR $@
echo "$( date -I'seconds' ) ClamAV scanning finished"
