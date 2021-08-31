#!/bin/bash

this_dir=$(dirname BASH_SOURCE[0])

config_file=".conf"

# Input parameters
if [[ ( $# -ne 4 ) ]]; then
    if [ ! -f "$config_file" ]; then
        echo "There are not Gitlab username."
        echo "Input Gitlab username (Required. For example: dhidalgo.hd fundacionchile ohernandezm patricio.merino)"
        read gitusername
        echo "There are not group."
        echo "Input group (Type Enter for empty)"
        read group
        echo "There are not access_key_id."
        echo "Input access_key_id (Type Enter for empty)"
        read access_key_id
        echo "There are not secret_access_key."
        echo "Input secret_access_key (Type Enter for empty)"
        read secret_access_key
        if [[ $gitusername != "" && $group != "" && $access_key_id != "" && $secret_access_key != "" ]]; then
            bash store-parameters.sh $gitusername $group $access_key_id $secret_access_key
        fi
    fi
else
    gitusername=$1
    group=$2
    access_key_id=$3
    secret_access_key=$4
    bash store-parameters.sh $gitusername $group $access_key_id $secret_access_key
fi

if [[ -f $config_file ]]; then
    source $config_file
fi

username=${SUDO_USER:-$USER}

if [[ $gitusername != "" && $username != "" ]]; then
    export HOME_FOLDER="/home/$username"
    export FCH_CHILE_SDK_FOLDER="$HOME_FOLDER/fch-chile-sdk"
    mkdir -p $FCH_CHILE_SDK_FOLDER
    cd $FCH_CHILE_SDK_FOLDER

    git config --global credential.helper store

    # Clone the config repo
    common_config="$FCH_CHILE_SDK_FOLDER/common-config"
    if [ ! -d "$common_config" ]; then
        cd $FCH_CHILE_SDK_FOLDER
        git clone https://github.com/pmerinodiaz/common-config.git
    else
        cd $common_config
        git fetch
        git checkout main
        git pull
    fi

    dist=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
    echo "Distribution Name: $dist"

    . /etc/os-release
    echo "ID_LIKE: $ID_LIKE"

    uname=$(uname -av)
    echo "Uname: $uname"

    # Install Core
    if [[ $dist == "Ubuntu" || $dist == "Debian" ]]; then
        bash $common_config/install-ubuntu-debian.sh
    elif [[ $ID_LIKE =~ .*fedora.* || $ID_LIKE =~ .*centos.* || $ID_LIKE =~ .*rhel.* ]]; then
        bash $common_config/install-fedora-centos-rhel.sh
    elif [[ $uname =~ .*Mac.* ]]; then
        bash $common_config/install-mac.sh
    fi

    # Configurations for User
    bash $common_config/configure-user.sh $gitusername $group $access_key_id $secret_access_key

    # Install Jupyter extension (Optional)
    bash $common_config/install-jupyter-extension.sh

    # S3 Optimize Throughput of Large Files (Optional)
    bash $common_config/configure-s3-optimize-large-files.sh

    # Show the versions
    bash $common_config/show-versions.sh

    cd $this_dir

    # Manage Docker as a non-root for the user
    bash $common_config/configure-docker.sh
fi
