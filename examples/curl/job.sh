#!/usr/bin/env bash
# Greenhouse Job API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./job.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/greenhouse/job" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=discord/8806482002 or https://job-boards.greenhouse.io/discord/jobs/8806482002.'
