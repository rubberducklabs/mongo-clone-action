#!/bin/bash

MONGO_URI_SOURCE=$1
MONGO_URI_TARGET=$2
EXCLUDE_COLLECTION=$3
DB_NAME_SOURCE="${MONGO_URI_SOURCE##*/}"
DB_NAME_TARGET="${MONGO_URI_TARGET##*/}"

exclude_collection=""

if [ -n "$EXCLUDE_COLLECTION" ]
  then
    for collection in $EXCLUDE_COLLECTION; do
      exclude_collection+=" --excludeCollection=$collection"
    done
fi

echo "mongodump --uri="${MONGO_URI_SOURCE}" --forceTableScan --archive $exclude_collection | mongorestore --uri="${MONGO_URI_TARGET}" --archive --nsInclude="${DB_NAME_SOURCE}.*" --nsFrom="${DB_NAME_SOURCE}.*" --nsTo="${DB_NAME_TARGET}.*" --drop"