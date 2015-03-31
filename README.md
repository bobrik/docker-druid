# Druid in docker

## [Base image](druid-base)

Base image is used to bake your own configuration.

## [Mesos base image](mesos-druid-base)

Base image that supports running on [marathon](https://mesosphere.github.io/marathon/).
This image should be used as base as well.

## [Example cluster](services)

Example cluster with kafka as realtime input and hdfs as deep storage
to run in boot2docker.
