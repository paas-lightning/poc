kubectl get nodes
NAMESPACE=bdf-credor-poc
QUOTAS=bdf-poc
# Create the Namespace:
kubectl create -f admin/namespaces/$NAMESPACE.json
# Create the ResourceQuota:
kubectl create -f admin/quotas/$QUOTAS.yaml --namespace=$NAMESPACE

# Role
kubectl create -f admin/rbac/rbac-role-default.yaml

# Private volume
kubectl create -f admin/volume/task-pv-volume.yaml --namespace=$NAMESPACE
# test 
kubectl get pv task-pv-volume 
# PVC
kubectl create -f admin/volume/task-pv-claim.yaml
# test
kubectl get pv task-pv-volume
