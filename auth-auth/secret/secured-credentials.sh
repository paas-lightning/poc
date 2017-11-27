#!/bin/bash

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <secret_name> <username> <password> <namespace> [create|delete]"
    echo "Example create: $0 test-secret my-app 'password' n1"
    echo "Example delete: $0 test-secret my-app 'password' n1 delete"
    exit -10
fi


# Distribute Credentials Securely Using Secrets
# See article : https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/

# Get parameters
secret=$2
user=$1
password=$3

if [ $password == "GENERATE" ]; then
  password=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9'   | head -c 15)
fi

namespace=$4
type="create"
if [ "$#" -gt 4 ]; then
    if [ $5 == "delete" ]; then
       type="delete"
       kubectl $type  namespace $namespace
       exit 1
    else 
       type="create"
    fi    
fi


podname="$secret-test-pod"
containername="$secret-test-container"

kubectl $type  namespace $namespace

echo "$type: secret $secret"
kubectl $type secret generic $secret --from-literal=username="$user" --from-literal=password="$password" -n $namespace

echo "$type: pod $podname"
cat <<EOF | kubectl $type -f -
apiVersion: v1
kind: Pod
metadata:
  name: $podname
  namespace: $namespace 
spec:
  containers:
  - name: $containername
    image: nginx
    env:
    - name: SECRET_USERNAME
      valueFrom:
        secretKeyRef:
          name: $secret
          key: username
    - name: SECRET_PASSWORD
      valueFrom:
        secretKeyRef:
          name: $secret
          key: password
EOF

sleep 10

echo "Checking that pod $podname within namespace $namespace contains secrets as envVars"
kubectl exec $podname  -it  -n $namespace  --  /usr/bin/env | grep SECRET

exit 1 
