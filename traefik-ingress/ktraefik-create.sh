NAMESPACE="poc"
ACCOUNT="traefik-ingress-controller"
kubectl create -f traefik-namespace.json
kubectl create -f traefik-clusterrolebinding.yaml --namespace $NAMESPACE
kubectl create -f traefik-configmap.yaml --namespace $NAMESPACE
kubectl create -f traefik-daemonset.yaml --namespace $NAMESPACE
kubectl create -f traefik-ingresscontroller.yaml --namespace $NAMESPACE
kubectl create -f traefik-serviceaccount.yaml --namespace $NAMESPACE
kubectl create -f traefik-service.yaml --namespace $NAMESPACE
#kubectl create serviceaccount $ACCOUNT --namespace $NAMESPACE
ACCOUNT_NAME="$(kubectl get serviceaccounts $ACCOUNT -o json --namespace=$NAMESPACE  | jq '.secrets[].name')"
echo "Account found : $ACCOUNT_NAME"  

kubectl get secret $(echo $ACCOUNT_NAME  | tr -d '"')  --namespace=$NAMESPACE

ca_crt=$(kubectl get secret $(echo $ACCOUNT_NAME  | tr -d '"') --namespace=$NAMESPACE -o json | jq '.data."ca.crt"')
echo $ca_crt | tr -d '"' | tr -d "\n"  > ca.crt
sudo rm /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
sudo cp ca.crt /var/run/secrets/kubernetes.io/serviceaccount/ca.crt

token=$(kubectl get secret $(echo $ACCOUNT_NAME  | tr -d '"') --namespace=$NAMESPACE -o json | jq '.data.token')
echo $token | tr -d '"' | tr -d "\n"  > token
sudo rm /var/run/secrets/kubernetes.io/serviceaccount/token
sudo cp token /var/run/secrets/kubernetes.io/serviceaccount/token




