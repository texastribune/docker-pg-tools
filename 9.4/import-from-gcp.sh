#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
set -o xtrace
set -o allexport

readonly filename=/tmp/pg.sql

gcloud auth login
gsutil cp ${GCP_SOURCE} ${filename}.gz
gunzip ${filename}.gz

TEMPLATE_DB=$(dirname ${DATABASE_URL})/template_db

phd TEMPLATE_DB dropdb --if-exists
phd TEMPLATE_DB createdb
phd TEMPLATE_DB psql -f ${filename}

phd dropdb
phd createdb --template=template_db
