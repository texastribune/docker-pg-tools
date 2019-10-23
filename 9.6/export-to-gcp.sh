#!/usr/bin/env bash

# Requires:
#   - google cloud sdk

set -o nounset
set -o errexit
set -o pipefail

# set -o allexport

: ${PROJECT_ID:?"PROJECT_ID must be set"}
: ${INSTANCE_NAME:?"INSTANCE_NAME must be set"}
: ${DATABASE_NAME:?"DATABASE_NAME must be set"}
: ${GCP_TARGET:?"S3_TARGET must be set"}

set -o xtrace

readonly filename=/tmp/db.pgdump

if [ -v "GCP_KEY_FILE" ]
then
  gcloud auth activate-service-account --key-file ${GCP_KEY_FILE}
else
  echo "No GCP_KEY_FILE variable...logging in manually"
  gcloud auth login
fi

# plain-text:
gcloud config set project ${PROJECT_ID}
gcloud sql export sql ${INSTANCE_NAME} ${GCP_TARGET} --database=${DATABASE_NAME}
