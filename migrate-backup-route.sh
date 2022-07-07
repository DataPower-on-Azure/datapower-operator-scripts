#!/bin/bash

#define parameters which are passed in.
NAME=$1
PORTS=${@: 1}

#define the template.
cat  << EOF
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "370"
  name: $NAME-route
  namespace: $NAME-migration
spec:
  to:
    kind: Service
    name: $NAME-service
    weight: 100
  port:
$(
  for PORT in {$PORTS}; do
    echo    targetPort: $NAME-mpgw
)
EOF
