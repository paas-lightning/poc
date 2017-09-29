#!/bin/bash 
echo 'Installing Traefik'



lb_ip="`hostname -i`"

export API_PROTOCOL="`kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].name'`"
export API_PORT="`kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].port'`"
export API_HOST="`kubectl get endpoints kubernetes -o json | jq '.subsets[].addresses[].ip'`"


#echo '1a2c12.70a86d6800ad6ae3' | tr -d "\n"  > token



if [ -f traefik.toml.template ];
then
	cp -f traefik.toml.template traefik.toml
	if [ $? != 0 ]
	then 
		echo "error copying toml template, Exiting"
		exit 1
	fi
else
	echo "toml error, Exiting"
	exit 1
fi
sed -i -- "s/API_PROTOCOL/$(eval echo $API_PROTOCOL)/g" traefik.toml
sed -i -- "s/API_HOST/$(eval echo $API_HOST)/g" traefik.toml
sed -i -- "s/API_PORT/$(echo $API_PORT)/g" traefik.toml

echo "$lb_ip controller.msepehr.com" | sudo tee --append /etc/hosts

sudo ./traefik -c traefik.toml
