#!/bin/bash

set -e

umask u+rxw,g+rwx,o-rwx

#
# PREPARE
#
# see: http://books.sonatype.com/nexus-book/reference3/install.html#config-data-directory
sed -i 's@-Dkaraf.data=../sonatype-work/nexus3@-Dkaraf.data=/nexus-home@g' /nexus/nexus-latest/bin/nexus.vmoptions
sed -i 's@-Djava.io.tmpdir=../sonatype-work/nexus3/tmp@-Djava.io.tmpdir=/nexus-home/tmp@g' /nexus/nexus-latest/bin/nexus.vmoptions
sed -i 's@-XX:LogFile=../sonatype-work/nexus3/log/jvm.log@-XX:LogFile=/nexus-home/log/jvm.log@g' /nexus/nexus-latest/bin/nexus.vmoptions
sed -i 's@jetty-http.xml,@jetty-http.xml,${jetty.etc}/jetty-https.xml,@g' /nexus/nexus-latest/etc/nexus-default.properties

echo "" >> /nexus/nexus-latest/etc/nexus-default.properties
echo "application-port-ssl=8443" >> /nexus/nexus-latest/etc/nexus-default.properties
# We use default password 'password' for keystrore, so we do not have to patch
# /nexus/nexus-latest/etc/jetty/jetty-https.xml

#
# SSL (see doc: https://support.sonatype.com/hc/en-us/articles/217542177-Using-Self-Signed-Certificates-with-Nexus-Repository-Manager-and-Docker-Daemon)
#
echo $NEXUS_KEYSTORE_JKS_BASE64 | base64 --decode > /nexus/nexus-latest/etc/ssl/keystore.jks
keytool -list -rfc -keystore keystore.jks  -storepass password

echo "DOCKER ENTRYPOINT >> ================================="
echo "DOCKER ENTRYPOINT >> "
echo "DOCKER ENTRYPOINT >> LIST CERTIFICATE - IF THERE ARE NO ERRORS ALL IS FINE"
keytool -list -rfc -keystore /nexus/nexus-latest/etc/ssl/keystore.jks  -storepass password
echo "DOCKER ENTRYPOINT >> "
echo "DOCKER ENTRYPOINT >> ================================="



#
# DIR CHECKS
#
if [ ! -d /nexus-home/etc ];  then mkdir /nexus-home/etc; fi
if [ ! -d /nexus-home/log ];  then mkdir /nexus-home/log; fi
if [ ! -d /nexus-home/tmp ];  then mkdir /nexus-home/tmp; fi

exec "$@"
