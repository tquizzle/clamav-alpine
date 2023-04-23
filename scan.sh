#!/bin/bash
set -euo pipefail
echo -e "$( date -I'seconds' ) ClamAV process starting \n"
echo -e "Unpdating ClamAV scan DB \n"
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo -e "Freshclam updated the DB \n"
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo -e "ClamAV DB already up to date... \n"
else
    echo -e "An error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT') \n"
    exit $FRESHCLAM_EXIT
fi
clamscan -V
echo -e "Scanning $SCANDIR \n"
clamscan -r $SCANDIR $@
echo -e "$( date -I'seconds' ) ClamAV scanning finished \n"
