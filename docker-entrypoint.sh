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
# see: http://books.sonatype.com/nexus-book/reference3/install.html#config-http-port
sed -i 's@application-port=8081@application-port=8333@g' /nexus/nexus-latest/etc/nexus-default.properties

if [ ! -d /nexus-home/log ];  then mkdir /nexus-home/log; fi
if [ ! -d /nexus-home/tmp ];  then mkdir /nexus-home/tmp; fi
if [ ! -d /nexus-home/data ]; then mkdir /nexus-home/data; fi

exec "$@"
