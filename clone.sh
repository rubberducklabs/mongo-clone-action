#!/bin/bash

MONGO_URI_SOURCE=$1
MONGO_URI_TARGET=$2
EXCLUDE_COLLECTION=$3
DB_NAME_SOURCE="${MONGO_URI_SOURCE##*/}"
DB_NAME_TARGET="${MONGO_URI_TARGET##*/}"

EXCLUDE_PARAM=""

if [ -n "$EXCLUDE_COLLECTION" ]
  then
    for COLL in $EXCLUDE_COLLECTION; do
      EXCLUDE_PARAM+=" --excludeCollection=$COLL"
    done
fi

mongodump --uri="${MONGO_URI_SOURCE}" --forceTableScan --archive "${EXCLUDE_PARAM}" | mongorestore --uri="${MONGO_URI_TARGET}" --archive --nsInclude="${DB_NAME_SOURCE}.*" --nsFrom="${DB_NAME_SOURCE}.*" --nsTo="${DB_NAME_TARGET}.*" --drop