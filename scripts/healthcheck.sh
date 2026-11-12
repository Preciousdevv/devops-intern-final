#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080}"

echo "Checking application health at: $URL"

if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is not installed." >&2
    exit 1
fi

if ! STATUS_CODE=$(curl --silent --show-error \
    --output /dev/null \
    --write-out "%{http_code}" \
    --max-time 10 "$URL"); then
    echo "Health check failed: Unable to reach $URL" >&2
    exit 1
fi

if [[ "$STATUS_CODE" == "200" ]]; then
    echo "Health check passed! HTTP status: $STATUS_CODE"
    exit 0
else
    echo "Health check failed! HTTP status: $STATUS_CODE" >&2
    exit 1
fi
