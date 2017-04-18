#!/bin/bash

set -e

umask u+rxw,g+rwx,o-rwx

#
# PREPARE
#
if [ ! -d /archiva-home/logs ]
then
    mkdir /archiva-home/logs
fi
if [ ! -d /archiva-home/data ]
then
    mkdir /archiva-home/data
fi
if [ ! -d /archiva-home/temp ]
then
    mkdir /archiva-home/temp
fi
if [ ! -d /archiva-home/conf ]
then
    mkdir /archiva-home/conf
    cp /work-private/conf/* /archiva-home/conf/
fi

#
# START
#
/archiva/apache-archiva-latest/bin/archiva start

sleep 2
echo "."
sleep 2
echo "."
sleep 2
echo "."
sleep 2
echo "."


exec "$@"
