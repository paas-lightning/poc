export USER=user01
export NS=authn
kubectl apply -f auth.yaml
export secret=$(kubectl get serviceaccounts $USER -n $NS -o jsonpath='{.secrets[].name}')
export token=$(kubectl get secret $secret -n $NS -o jsonpath='{.data.token}' | base64 -D)
#export token=$(kubectl get secret $secret -n $NS -o jsonpath='{.data.token}')
export cacrt=$(kubectl get secret $secret -n authn -o jsonpath='{.data.ca\.crt}')
rm config
cp config.template config
export API_PROTOCOL=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].name')
export API_HOST=$(minikube ip)
#export API_HOST=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].addresses[].ip')
export API_PORT=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].port')
sed -i '' "s/\<API_PROTOCOL\>/$(eval echo $API_PROTOCOL)/g" config
sed -i '' "s/\<API_HOST\>/$(eval echo $API_HOST)/g" config
sed -i '' "s/\<API_PORT\>/$(eval echo $API_PORT)/g" config
sed -i '' "s/\<TOKEN\>/$(eval echo $token)/g" config
sed -i '' "s/\<CACRT\>/$(eval echo $cacrt)/g" config
sed -i '' "s/\<USER\>/$(eval echo $USER)/g" config
echo "Add the following config at home directory like '$HOME/.kube/config' file for kubectl: the config file"
cat config