FROM bobrik/mesos-druid-base:0.7.0

RUN /pull.sh '["io.druid.extensions:druid-hdfs-storage","io.druid.extensions:druid-kafka-eight","io.druid.extensions:mysql-metadata-storage"]'

ADD ./runtime.properties /opt/druid/config/realtime/runtime.properties
ADD ./example-druid.spec.json /example-druid.spec.json

ENTRYPOINT ["/run-mesos.sh", "realtime"]
