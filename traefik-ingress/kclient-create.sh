NAMESPACE=poc-client

kubectl create -f client-namespace.json 
kubectl create -f client-quotas.yaml --namespace=$NAMESPACE
kubectl create -f client-deploy.yaml --namespace=$NAMESPACE
kubectl create -f client-svc-clusterip.yaml --namespace=$NAMESPACE
kubectl create -f client-svc-nodeport.yaml --namespace=$NAMESPACE
kubectl get services --namespace=$NAMESPACE
kubectl create -f client-ingress.yaml  --namespace=$NAMESPACE
kubectl get ingress --namespace=$NAMESPACE
