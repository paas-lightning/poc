https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_config_set-credentials/
# Set only the "client-key" field on the "cluster-admin"
# entry, without touching other values:
kubectl config set-credentials cluster-admin --client-key=~/.kube/admin.key

# Set basic auth for the "cluster-admin" entry
kubectl config set-credentials cluster-admin --username=admin --password=uXFGweU9l35qcif

# Embed client certificate data in the "cluster-admin" entry
kubectl config set-credentials cluster-admin --client-certificate=~/.kube/admin.crt --embed-certs=true
kubectl config set-credentials cluster-admin --username=useradmin --password=password