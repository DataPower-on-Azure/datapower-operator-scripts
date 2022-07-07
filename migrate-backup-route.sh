#!/bin/sh

#define parameters which are passed in.
NAME=$1
PORTS=$@

PORTLIST=$(
  for PORT in {$PORTS}; do
    if [[ "x$PORT" == "x$NAME" ]]; then
      echo "    targetPort: $NAME-$PORT";
    else
      echo "x$PORT" "x$NAME"
    fi
  done;
)

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
$PORTLIST
EOF
