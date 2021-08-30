#!/bin/bash

# How : DataScientist or Developer
# Want: Install the work environment
# For : Develop applications

username=${SUDO_USER:-$USER}
export HOME_FOLDER="/home/$username"
export FCH_CHILE_SDK_FOLDER="$HOME_FOLDER/fch-chile-sdk"
cd $FCH_CHILE_SDK_FOLDER

git clone https://gitlab.com/pmerinodiaz/vscode-local.git
cd vscode-local
./install.sh <group> <access_key_id> <secret_access_key>