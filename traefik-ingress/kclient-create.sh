NAMESPACE=poc

kubectl create -f client-deploy.yaml --namespace=$NAMESPACE
kubectl create -f client-svc-clusterip.yaml --namespace=$NAMESPACE
kubectl get services --namespace=$NAMESPACE
kubectl create -f client-ingress.yaml  --namespace=$NAMESPACE
kubectl get ingress --namespace=$NAMESPACE
kubectl create -f client-quotas.yaml --namespace=$NAMESPACE
