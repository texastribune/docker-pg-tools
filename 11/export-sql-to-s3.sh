#!/usr/bin/env bash

# Requires:
#   - awscli
#   - postdoc
#   - AWS credentials need to be provided in environment or via IAM role
#   - postgres client

set -o nounset
set -o errexit
set -o pipefail

# set -o allexport

: ${DATABASE_URL:?"DATABASE_URL must be set"}
: ${S3_TARGET:?"S3_TARGET must be set"}

set -o xtrace

readonly filename=/tmp/db.sql

phd pg_dump --inserts --format p --file=${filename}
aws s3 mv ${filename} ${S3_TARGET}
