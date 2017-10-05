set -x
# https://docs.traefik.io/user-guide/kubernetes/

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml
#wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml
#kubectl create -f traefik-rbac.yaml

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml
#wget https://github.com/containous/traefik/tree/master/examples/k8s/traefik-deployment.yaml
#kubectl create -f traefik-deployment.yaml

#wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml
#kubectl create -f traefik-ds.yaml 
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml

kubectl --namespace=kube-system get pods

#You should now be able to access Træfik on port 80 of your Minikube instance when using the DaemonSet:
curl $(minikube ip)


kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml
#wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml
#kubectl create -f ui.yaml

kubectl get services --namespace=kube-system


echo "$(minikube ip) traefik-ui.minikube" | sudo tee -a /etc/hosts

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
#wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
#kubectl create -f cheese-deployments.yaml

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
#wget kubectl https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
#kubectl create -f cheese-services.yaml

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
#wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
#kubectl create -f cheese-ingress.yaml


