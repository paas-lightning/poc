#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo 'Usage: ./install-users.sh <input.csv> <output_credentials.csv> <output_config_dir>'
    echo 'Example: ./install-users.sh usernames.csv credentials_file.csv configs'
    exit -10
fi

# Get parameters
users_file=$1
credentials_file=$2
config_dir=$3

./credentials.sh $users_file $credentials_file
if [ $? -lt 0 ]
then
   echo "Error occured during ./credential.sh. Exiting..."
   exit -1
fi

./configs.sh $credentials_file $config_dir
if [ $? -lt 0 ]
then
   echo "Error occured during ./config.sh. Exiting..."
   exit -2
fi


