NAMESPACE="poc"
ACCOUNT="traefik-ingress-controller"
kubectl delete -f traefik-clusterrolebinding.yaml --namespace $NAMESPACE
kubectl delete -f traefik-configmap.yaml --namespace $NAMESPACE
kubectl delete -f traefik-daemonset.yaml --namespace $NAMESPACE
kubectl delete -f traefik-ingresscontroller.yaml --namespace $NAMESPACE
kubectl delete -f traefik-serviceaccount.yaml --namespace $NAMESPACE
kubectl delete -f traefik-service.yaml --namespace $NAMESPACE
#kubectl delete serviceaccount $ACCOUNT --namespace $NAMESPACE
kubectl delete -f traefik-namespace.json


