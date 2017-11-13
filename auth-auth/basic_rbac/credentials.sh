#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo 'Usage: ./credentials.sh <input.csv> <output.csv>'
    echo 'Example: ./credentials.sh usernames.csv credentials_file.csv'
    exit -10 
fi


# Get the password from the kismatic yaml ?
ADMIN_PASSWORD="TOBE_DETERMINED"

# Get parameters
users_file=$1
credentials_file=$2

if [ -e $credentials_file ]
then
   read -p "Are you sure you want to remove the credential file?" -n 1 -r
   if [[ $REPLY =~ ^[Yy]$ ]]
   then
      rm $credentials_file
   fi
fi
echo " "

### function line per line
generate()
{
    echo "$3,$1,$2,system:masters" >> $credentials_file
    return 1
}

# Load the usernames and put them into an array 
users=( $(cut -d ',' -f2 $users_file ) )

generate "admin" 999  $ADMIN_PASSWORD
for((i=0;i<${#users[@]};i++))
do
    password=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9'   | head -c 15)
    generate ${users[$i]} $i $password
done

# Restart apiserver : docker stop and get the ID and then docker rm ID

# 

exit 1
