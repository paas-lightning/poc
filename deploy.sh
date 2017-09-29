
NAMESPACE=poc-01
QUOTAS=poc-01
APP=webserver-nginx

## app deploy
kubectl create -f deployments/$APP.yaml --namespace=$NAMESPACE
# tests
kubectl get resourcequota $QUOTAS --namespace=$NAMESPACE --output=yaml
kubectl get deployment $APP --namespace=$NAMESPACE --output=yaml
kubectl get replicasets  --namespace=$NAMESPACE
kubectl get pods --namespace=$NAMESPACE 

## service deploy
kubectl create -f services/$APP-svc.yaml --namespace=$NAMESPACE
# tests
kubectl get services --namespace=$NAMESPACE


kubectl get pods -l app=$APP --namespace=$NAMESPACE 


## Added the howto to reach from outside the application
kubectl describe svc $APP --namespace=$NAMESPACE
# get the node port
kubectl cluster-info 
# get the cluster IP
curl $CLUSTER_IP:$NODEPORT
# verify nginx is connected from outside 


# kubectl run --image=nginx nginx-app --port=80 --env="DOMAIN=cluster"

# export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
# echo Name of the Pods: $POD_NAME

# kubectl run hello-app --image=gcr.io/nginx-ingress-dev/hello:0.1 --port 80 -- replicas=2
# creates a service : only available with a external ip
# kubectl expose deployment hello-app --type=LoadBalancer
# get svc hello-app
# NAME        CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
# hello-app   10.0.0.112   <pending>     80:30190/TCP   1m
# Should not be pending
