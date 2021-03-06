set -x
# https://docs.traefik.io/user-guide/kubernetes/

## Role Based Access Control configuration
## Authorizes Traefik to use the Kubernetes API by using ClusterRole and ClusterRoleBinding resources:
kubectl apply -f traefik-rbac.yaml

## Deploy Traefik using a Deployment or DaemonSet and ServiceAccount and Service NodePort
kubectl apply -f traefik-deployment.yaml
kubectl apply -f traefik-ds.yaml 

kubectl --namespace=kube-system get pods

## The user should now be able to access Traefik on port 80 of your Minikube instance when using the DaemonSet:
## 404 Exptected
curl $(minikube ip)


## Installing Traefik using Helm
helm install stable/traefik

## Traefik Web UI using Ingress Service 
kubectl apply -f ui.yaml

kubectl get services --namespace=kube-system

## Route to kube node ip 
echo "$(minikube ip) traefik-ui.minikube" | sudo tee -a /etc/hosts

## Deploy Web Applications as clients using Deployment
kubectl apply -f cheese-deployments.yaml

## Setup Services to the clients using targetPorts
kubectl apply -f cheese-services.yaml

## Setup Ingress Services for clients
kubectl apply -f cheese-ingress.yaml



