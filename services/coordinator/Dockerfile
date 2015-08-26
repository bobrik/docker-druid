FROM bobrik/mesos-druid-base:0.8.0

RUN /pull.sh '["io.druid.extensions:druid-hdfs-storage","io.druid.extensions:druid-kafka-eight","io.druid.extensions:mysql-metadata-storage","io.druid.extensions:postgresql-metadata-storage"]'

ADD ./runtime.properties /opt/druid/config/coordinator/runtime.properties

ENTRYPOINT ["/run-mesos.sh", "coordinator"]
