#!/bin/bash

set -e

DRUID_NODE_TYPE=$1
if [ -z $DRUID_NODE_TYPE ]; then
    echo "DRUID_NODE_TYPE (1st image argument) is not set"
    exit 1
fi

if [ -z $DRUID_MEMORY_LIMIT ]; then
    echo "DRUID_MEMORY_LIMIT is not set"
    exit 1
fi

if [ -z $DRUID_HOST ]; then
    DRUID_HOST=$(ip addr | grep 'eth0' | awk '{print $2}' | cut -f1  -d'/' | tail -1)
fi

DRUID_PORT=${DRUID_PORT:-8000}

echo "druid.host=${DRUID_HOST}" > /opt/druid/config/_common/common.runtime.properties
echo "druid.port=${DRUID_PORT}" >> /opt/druid/config/_common/common.runtime.properties

for VAR in $(env); do
    if [[ $VAR =~ ^DRUID_CONFIG_ ]]; then
        druid_name=$(echo "$VAR" | sed -r "s/DRUID_CONFIG_(.*)=.*/\1/g" | tr _ .)
        env_value=$(echo "$VAR" | sed -r "s/(.*)=.*/\1/g")
        if egrep -q "(^|^#)$druid_name=" /opt/druid/config/${DRUID_NODE_TYPE}/runtime.properties; then
            sed -r -i "s@(^|^#)($druid_name)=(.*)@\2=${!env_value}@g" "/opt/druid/config/${DRUID_NODE_TYPE}/runtime.properties"
        else
            echo "$druid_name=${!env_value}" >> "/opt/druid/config/${DRUID_NODE_TYPE}/runtime.properties"
        fi
    fi
done

cat "/opt/druid/config/${DRUID_NODE_TYPE}/runtime.properties"

# workaround for https://github.com/druid-io/druid/pull/1022
DRUID_EXTRA_CLASSPATH=:$(find /opt/druid/repository -type f -name "*.jar" -not -path "*io/druid/extensions*" -printf '%p:' | sed 's/:$//')

echo CLASSPATH "/opt/druid/config/_common:/opt/druid/config/${DRUID_NODE_TYPE}:/opt/druid/lib/*:${DRUID_EXTRA_CLASSPATH}"

exec java "-Xmx${DRUID_MEMORY_LIMIT}" \
    -Duser.timezone=UTC \
    -Dfile.encoding=UTF-8 \
    -classpath "/opt/druid/config/_common:/opt/druid/config/${DRUID_NODE_TYPE}:/opt/druid/lib/*:${DRUID_EXTRA_CLASSPATH}" io.druid.cli.Main server "${DRUID_NODE_TYPE}"
