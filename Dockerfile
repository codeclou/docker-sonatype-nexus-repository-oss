FROM codeclou/docker-oracle-jdk:8u121


ENV ARCHIVA_VERSION 2.2.1
ENV ARCHIVA_MD5SUM  ff4a83007ac10fe4add308d22dfbc3d6

RUN addgroup -g 10777 worker && \
    adduser -h /work -H -D -G worker -u 10777 worker && \
    mkdir -p /work && \
    mkdir -p /work-private && \
    mkdir /archiva && mkdir /archiva-home && \
    chown -R worker:worker /work/ && \
    chown -R worker:worker /work-private/ && \
    apk add --no-cache \
            bash \
            curl \
            tar \
            python \
            py-pip && \
            pip install shinto-cli && \
    curl -jkSL -o /opt/apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz \
         http://mirror.synyx.de/apache/archiva/${ARCHIVA_VERSION}/binaries/apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz  && \
    cd /archiva && \
    echo "${ARCHIVA_MD5SUM}  apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz" > apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz-md5sum \
    md5sum -c apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz-md5sum \
    tar zxf /opt/apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz -C /archiva && \
    rm /opt/apache-archiva-${ARCHIVA_VERSION}-bin.tar.gz && \
    chown -R worker:worker /archiva && \
    chown -R worker:worker /archiva-home/

    
    
    
