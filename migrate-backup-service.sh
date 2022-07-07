#!/bin/bash

#define parameters which are passed in.
NAME=$1
PORTS=$@

PORTLIST=$(
  for PORT in {$PORTS}; do
    echo    - name: $NAME-$PORT;
    echo      protocol: TCP;
    echo      port: $PORT;
    echo      targetPort: $PORT;
  done;
)

#define the template.
cat  << EOF
kind: Service
apiVersion: v1
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "360"
  name: $NAME-service
  namespace: $NAME-migration
spec:
  selector:
    app.kubernetes.io/instance: $NAME-migration-$NAME-instance
  ports:
$PORTLIST
EOF