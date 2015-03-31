#!/bin/sh

set -e

docker build -t bobrik/druid-base:0.7.0 druid-base
docker build -t bobrik/mesos-druid-base:0.7.0 mesos-druid-base

for service in broker coordinator historical overlord realtime; do
    cat services/common.properties services/$service/service.properties > services/$service/runtime.properties
    docker build -t bobrik/mesos-druid-$service:0.7.0 services/$service
done
