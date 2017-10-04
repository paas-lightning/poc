!/bin/bash
echo 'Starting Tests...'

set -x

#lb_ip="`hostname -i`"

export API_PROTOCOL="`kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].name' | tr -d '"' `"
export API_PORT="`kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].port' | tr -d '"' `"
export API_HOST="`kubectl get endpoints kubernetes -o json | jq '.subsets[].addresses[].ip' | tr -d '"' `"

NAMESPACE="poc"
kubectl get pods -n $NAMESPACE
kubectl get pods -n poc-client
kubectl get replicaset -n poc-client
kubectl get service -n $NAMESPACE
kubectl get service -n poc-client

curl -k --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" "$API_PROTOCOL://$API_HOST:$API_PORT/apis/extensions/v1beta1/namespaces/$NAMESPACE/ingresses"
