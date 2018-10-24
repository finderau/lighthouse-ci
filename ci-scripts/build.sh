#!/bin/sh

set -e

DIR=$(dirname "$(readlink -f "$0")")
. "${DIR}"/../ci-scripts-global/global-config.sh
. "${DIR}"/../.service-config.sh

docker build --no-cache \
  -t "${BRANCH_TAG}" \
  -t "${BRANCH_COMMIT_TAG}" \
  -t "${BRANCH_TAG_USWEST1}" \
  -t "${BRANCH_COMMIT_TAG_USWEST1}" \
  "${DIR}/../builder"
