set -x
# https://docs.traefik.io/user-guide/kubernetes/

## Role Based Access Control configuration
## Authorizes Traefik to use the Kubernetes API by using ClusterRole and ClusterRoleBinding resources:
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml

## Deploy Traefik using a Deployment or DaemonSet and ServiceAccount and Service NodePort
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml


## The user should now be able to access Traefik on port 80 of your Minikube instance when using the DaemonSet:
## 404 Exptected
curl $(minikube ip)


## Installing Traefik using Helm
helm install stable/traefik

## Traefik Web UI using Ingress Service 
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml



## Deploy Web Applications as clients using Deployment
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml

## Setup Services to the clients using targetPorts
kubectl apply -f cheese-services.yaml

## Setup Ingress Services for clients
wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml



