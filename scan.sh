#!/bin/bash
set -euo pipefail
echo -en "$( date -I'seconds' ) ClamAV process starting \n"
echo -en "Unpdating ClamAV scan DB \n"
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo -en "Freshclam updated the DB \n"
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo -en "ClamAV DB already up to date... \n"
else
    echo -en "An error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT') \n"
    exit $FRESHCLAM_EXIT
fi
clamscan -V
echo -en "Scanning $SCANDIR \n"
clamscan -r $SCANDIR $@
echo -en "$( date -I'seconds' ) ClamAV scanning finished \n"
