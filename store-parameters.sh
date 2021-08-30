#!/bin/bash

# Input parameters
if [[ ( $# -eq 4 ) ]]; then
    echo "There are not group."
    echo "Input group (Type Enter for empty)"
    read group
    echo "There are not access_key_id."
    echo "Input access_key_id (Type Enter for empty)"
    read access_key_id
    echo "There are not secret_access_key."
    echo "Input secret_access_key (Type Enter for empty)"
    read secret_access_key
else
    group=$1
    access_key_id=$2
    secret_access_key=$3
fi

# Store the parameters for comming installations
config_file=".conf"
rm -rf $config_file
touch $config_file
echo "export GROUP=$group" > $config_file
echo "export ACCESS_KEY_ID=$access_key_id" >> $config_file
echo "export SECRET_ACCESS_KEY=$secret_access_key" >> $config_file