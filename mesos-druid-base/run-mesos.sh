#!/bin/sh

set -e

export DRUID_HOST=$HOST
export DRUID_PORT=$PORT

/run.sh $@
