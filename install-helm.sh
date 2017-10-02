f=helm-v2.6.1-linux-amd64.tar.gz
kube=192.168.0.3:6443
wget https://storage.googleapis.com/kubernetes-helm/$f
tar -zxvf $f
mv linux-amd64/helm /usr/local/bin/helm
sudo mv linux-amd64/helm /usr/local/bin/helm
helm install --wait --timeout 1200   --kube-context $kube 
KADMIN=/home/centos/paas-lightning/etc-kubernetes-admin.conf
cp $KADMIN  $HOME/.kube/config
helm init
# Happy Helming!
kubectl config current-context
# See https://docs.helm.sh/using_helm/
helm init --upgrade
helm repo update 
# test it ::: helm install stable/mysql
