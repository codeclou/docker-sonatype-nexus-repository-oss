#!/bin/bash

set -e

curl -s --insecure https://localhost:8443 > /dev/null

##
## USAGE inside a stateful set of kubernetes
##
#  livenessProbe:
#    exec:
#      command: 
#      - bash
#      - /work-private/k8s-readiness-probe.sh
#    initialDelaySeconds: 60
#    timeoutSeconds: 5
#  readinessProbe:
#      command: 
#      - bash
#      - /work-private/k8s-readiness-probe.sh
#    initialDelaySeconds: 60
#    timeoutSeconds: 5
