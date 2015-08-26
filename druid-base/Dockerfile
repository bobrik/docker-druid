FROM java:8-jre

ENV DRUID_VERSION 0.8.0

RUN mkdir /opt/druid && \
    curl -L "http://static.druid.io/artifacts/releases/druid-${DRUID_VERSION}-bin.tar.gz" | tar zx --strip-components 1 -C /opt/druid

ADD ./pull.sh /pull.sh

ADD ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
