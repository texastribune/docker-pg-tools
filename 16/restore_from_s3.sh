#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o xtrace
set -o allexport

readonly filename=/tmp/pg.dump

: ${DATABASE_URL:?"DATABASE_URL must be set"}
: ${S3_SOURCE:?"S3_SOURCE must be set"}

# remove db name from DATABASE_URL
TEMPLATE_DB=$(dirname ${DATABASE_URL})

aws s3 cp ${S3_SOURCE} ${filename}
pg_restore -d $TEMPLATE_DB --jobs=8 --verbose --if-exists --clean --create --no-owner ${filename}
