#!/bin/bash

# How : DataScientist or Developer
# Want: Read the dataset from S3
# For : Perform analysis of the data

username=${SUDO_USER:-$USER}
export HOME_FOLDER="/home/$username"
export FCH_CHILE_SDK_FOLDER="$HOME_FOLDER/fch-chile-sdk/common-mlops"
cd $FCH_CHILE_SDK_FOLDER
source venv/bin/activate

python3 s3select.py -h
python3 s3select.py -l 300 -d , s3://oceania-dvc/existing-data/TaraContextData.csv.gz
python3 s3select.py -d , -v s3://oceania-dvc/existing-data/TaraContextData.csv.gz
python3 s3select.py -d , -v -c s3://oceania-dvc/existing-data/TaraContextData.csv.gz
python3 s3select.py -l 3 -d , -w "s._3 like '%TARA_G000000423%'" s3://oceania-dvc/existing-data/TaraContextData.csv.gz