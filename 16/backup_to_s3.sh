set -o nounset
set -o errexit

: ${DATABASE_URL:?"DATABASE_URL must be set"}
: ${S3_TARGET:?"S3_TARGET must be set"}

set -o xtrace

readonly filename=/tmp/db.pgdump

pg_dump $DATABASE_URL --format=custom --verbose --file=${filename}
aws s3 cp ${filename} ${S3_TARGET}/pg.dump
# add date to filename
aws s3 cp ${filename} ${S3_TARGET}/pg-$(TZ=UTC6CST date +%Y-%m-%d-%H-%M).dump