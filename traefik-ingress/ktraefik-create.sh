NAMESPACE="poc"
ACCOUNT="poc-saccount"
SA_PATH="/var/run/secrets/kubernetes.io/serviceaccount/"
#set -x


NS=$(kubectl get namespaces -ojson | grep  "$NAMESPACE" )
while [ -n "$NS" ]; do
  echo "Namespace $NAMESPACE still exists, remove it to continue"
  sleep 5
  NS=$(kubectl get namespaces -ojson | grep  "$NAMESPACE" )
done


kubectl create -f traefik-namespace.json
kubectl create -f traefik-clusterrolebinding.yaml --namespace $NAMESPACE
kubectl create -f traefik-configmap.yaml --namespace $NAMESPACE
kubectl create -f traefik-daemonset.yaml --namespace $NAMESPACE
kubectl create -f traefik-ingresscontroller.yaml --namespace $NAMESPACE
kubectl create -f traefik-serviceaccount.yaml --namespace $NAMESPACE
kubectl create -f traefik-service.yaml --namespace $NAMESPACE
#kubectl create serviceaccount $ACCOUNT --namespace $NAMESPACE
SECRET_NAME="$(kubectl get serviceaccounts $ACCOUNT -o json --namespace=$NAMESPACE  | jq '.secrets[].name')"
echo "Account found : $SECRET_NAME"  

kubectl get secret $(echo $SECRET_NAME  | tr -d '"')  --namespace=$NAMESPACE

ca_crt=$(kubectl get secret $(echo $SECRET_NAME  | tr -d '"') --namespace=$NAMESPACE -o json | sed "s/ca\.crt/ca_crt/g"	 | jq '.data.ca_crt')
echo $ca_crt | tr -d '"' | tr -d "\n" |  base64 -d > ca.crt

sudo mkdir -p $SA_PATH

sudo rm "${SA_PATH}ca.crt"
sudo cp ca.crt $SA_PATH

token=$(kubectl get secret $(echo $SECRET_NAME  | tr -d '"') --namespace=$NAMESPACE -o json | jq '.data.token' | tr -d '"' | base64 -d)

echo $token | tr -d '"' | tr -d "\n"  > token
sudo rm "${SA_PATH}token"
sudo cp token $SA_PATH


./kclient-create.sh

