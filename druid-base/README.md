# Druid base image

## Usage

This image expects you to provide configuration file bind-mounted to
`/opt/druid/config/${DRUID_NODE_TYPE}/runtime.properties`. Usage:

```
docker run -d \
    --net host \
    -e DRUID_HOST=10.10.10.10 \
    -e DRUID_PORT=8001 \
    -e DRUID_MEMORY_LIMIT=256m \
    -v /etc/druid/coordinator.properties:/opt/druid/config/coordinator/runtime.properties
    --name druid-broker bobrik/druid-base coordinator
```

This would use `/etc/druid/coordinator.properties` to run coordinator node
with 256m of heap for JVM on address `10.10.10.10:8001`. Note that host
networking is required since druid does not support port mapping yet.

It's a good idea to create your own druid images for each service
with configuration files baked in.

You might as well overwrite configuration directive instead of overwriting
the whole config. To use it, prefix directive name with `DRUID_CONFIG_` and
replace `.` in directive name with `_` and provide env variable with this
name. For example `druid.storage.type=local` can be passed as
`DRUID_CONFIG_druid_storage_type=local`.

## Example image

Example image for coordinator node:

```
FROM bobrik/druid-base:0.7.0

ADD ./runtime.properties /opt/druid/config/coordinator/runtime.properties

ENTRYPOINT ["/run.sh", "coordinator"]
```

Extra script `/pull.sh` is provided to pull druid extensions at build time,
here's how pull hdfs, kafka and mysql extensions:

```
RUN /pull.sh '["io.druid.extensions:druid-hdfs-storage","io.druid.extensions:druid-kafka-eight","io.druid.extensions:mysql-metadata-storage"]'
```

If you don't pull dependencies on at build time, you are going to wait
forever for your nodes to start up.
