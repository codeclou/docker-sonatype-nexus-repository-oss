FROM codeclou/docker-oracle-jdk:8u131

ENV NEXUS_OSS_VERSION 3.3.0-01
ENV NEXUS_OSS_MD5SUM  54cf2d9da3cdeb6ab7dc54f0008bf9a7

RUN addgroup -g 10777 worker && \
    adduser -h /work -H -D -G worker -u 10777 worker && \
    mkdir -p /work && \
    mkdir -p /work-private && \
    mkdir /nexus && mkdir /nexus-home && \
    chown -R worker:worker /work/ && \
    chown -R worker:worker /work-private/ && \
    apk add --no-cache \
            bash \
            curl \
            tar \
            python \
            py-pip && \
            pip install shinto-cli && \
    curl -jkSL -o /opt/nexus-${NEXUS_OSS_VERSION}-unix.tar.gz \
         http://download.sonatype.com/nexus/3/nexus-${NEXUS_OSS_VERSION}-unix.tar.gz  && \
    cd /opt && \
    echo "${NEXUS_OSS_MD5SUM}  nexus-${NEXUS_OSS_VERSION}-unix.tar.gz" > nexus-${NEXUS_OSS_VERSION}-unix.tar.gz-md5sum && \
    md5sum -c nexus-${NEXUS_OSS_VERSION}-unix.tar.gz-md5sum && \
    tar zxf /opt/nexus-${NEXUS_OSS_VERSION}-unix.tar.gz -C /nexus && \
    rm /opt/nexus-${NEXUS_OSS_VERSION}-unix.tar.gz && \
    cd /nexus && \
    ln -s nexus-${NEXUS_OSS_VERSION} nexus-latest && \
    chown -R worker:worker /nexus && \
    chown -R worker:worker /nexus-home/

#
# FILES
#
COPY docker-entrypoint.sh /work-private/docker-entrypoint.sh
COPY conf /work-private/conf
RUN chmod u+rx,g+rx,o+rx,a-w /work-private/docker-entrypoint.sh && \
    chown -R worker:worker /work-private/
    
#
# WORKDIR
#
WORKDIR /work
EXPOSE 8333

#
# RUN
#
USER worker
ENV NEXUS_OSS_BASE /nexus-home
VOLUME ["/work"]
VOLUME ["/nexus-home"]
ENTRYPOINT ["/work-private/docker-entrypoint.sh"]
CMD ["/nexus/nexus-latest/bin/nexus", "run"]
