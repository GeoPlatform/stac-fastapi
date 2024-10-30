#!/bin/bash
set -e

bash -c "docker-entrypoint.sh postgres &"
/tmp/wait-for-pg-isready.sh
python -m stac_fastapi.pgstac.app