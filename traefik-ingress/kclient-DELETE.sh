NAMESPACE=poc

kubectl delete -f client-deploy.yaml --namespace=$NAMESPACE
kubectl delete -f client-svc-clusterip.yaml --namespace=$NAMESPACE
kubectl delete -f client-ingress.yaml

