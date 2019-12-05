#!/usr/bin/env bash
#
CURRDIR="${PWD}"
cd $(dirname "$0")
SCRIPTDIR="${PWD}"
cd "${CURRDIR}"

#REMOTE_HOST="goober"
REMOTE_HOST="galenrhodes.com"
REMOTE_USER="grhodes"
REMOTE_PATH="Projects/2019"

rsync -avz --delete-after "${SCRIPTDIR}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

exit "$?"
