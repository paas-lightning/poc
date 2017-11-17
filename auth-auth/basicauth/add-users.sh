#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo 'Usage: ./add-users.sh <input.csv> <output_config_dir>'
    echo 'Example: ./add-users.sh usernames.csv configs'
    exit -10
fi

# Get parameters
users_file=$1
config_dir=$2

mkdir -p $config_dir

### function line per line
adduser()
{
  user=$1
  config_dir=$2

  ./add-user.sh $user $config_dir
  if [ $? -lt 0 ]
  then
     echo "Error occured during ./add-user.sh. Exiting..."
     exit -2
  fi

  
  return 1
}


# Load the usernames and put them into an array
users=( $(cut -d ',' -f2 $users_file ) )



for((i=0;i<${#users[@]};i++))
do
    adduser "${users[$i]}" $config_dir
#    exit -100 
done


