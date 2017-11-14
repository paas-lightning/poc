#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo 'Usage: ./configs.sh <input.csv> <output_directory>'
    echo 'Example: ./configs.sh credentials_file.csv configs'
    exit -10
fi




users_file=$1
output_dir=$2
mkdir -p $output_dir 


### function line per line
config()
{
  user=$1
  password=$2
  output_dir=$3
  config="$output_dir/config.$user"

  [ -e $config ] && rm $config
  cp config.template $config
     
  API_PROTOCOL=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].name')
  #API_HOST=$(minikube ip)
  API_HOST=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].addresses[].ip')
  API_PORT=$(kubectl get endpoints kubernetes -o json | jq '.subsets[].ports[].port')
  sed -i  "s/<API_PROTOCOL>/$(eval echo $API_PROTOCOL)/g" $config
  sed -i  "s/<API_HOST>/$(eval echo $API_HOST)/g" $config
  sed -i  "s/<API_PORT>/$(eval echo $API_PORT)/g" $config
  sed -i  "s/<PASSWORD>/$(eval echo $password)/g" $config
  sed -i  "s/<USER>/$(eval echo $user)/g" $config
  echo "The config file $config has been added"
  #cat $config
  return 1
}

# Load the usernames and put them into an array
users=( $(cut -d ',' -f2 $users_file ) )
passwords=( $(cut -d ',' -f1 $users_file ) )

for((i=0;i<${#users[@]};i++))
do
    config ${users[$i]} ${passwords[$i]} $output_dir
done

exit 1
