#!/bin/sh

set -e

exec java -cp "/opt/druid/config/_common:/opt/druid/lib/*" \
    "-Ddruid.extensions.coordinates=$1" \
    -Ddruid.extensions.localRepository=/opt/druid/repository \
    io.druid.cli.Main tools pull-deps
