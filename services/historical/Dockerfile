FROM bobrik/mesos-druid-base:0.7.0

RUN /pull.sh '["io.druid.extensions:druid-hdfs-storage","io.druid.extensions:druid-kafka-eight","io.druid.extensions:mysql-metadata-storage"]'

ADD ./runtime.properties /opt/druid/config/historical/runtime.properties

ENTRYPOINT ["/run-mesos.sh", "historical"]
