#!/bin/bash
set -euo pipefail
echo ""
echo -e "$( date -I'seconds' ) ClamAV process starting"
echo ""
echo -e "Unpdating ClamAV scan DB"
echo ""
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo ""
    echo -e "Freshclam updated the DB"
    echo ""
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo ""
    echo -e "ClamAV DB already up to date..."
    echo ""
else
    echo ""
    echo -e "An error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT')"
    echo ""
    exit $FRESHCLAM_EXIT
fi
clamscan -V
echo ""
echo -e "Scanning $SCANDIR"
echo ""
clamscan -r $SCANDIR $@
echo ""
echo -e "$( date -I'seconds' ) ClamAV scanning finished"
