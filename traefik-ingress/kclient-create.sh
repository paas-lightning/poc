NAMESPACE=poc

kubectl create -f client-deploy.yaml --namespace=$NAMESPACE
kubectl create -f client-svc-clusterip.yaml --namespace=$NAMESPACE
kubectl get services --namespace=$NAMESPACE
kubectl create -f client-ingress.yaml
kubectl get ingress --namespace=$NAMESPACE

