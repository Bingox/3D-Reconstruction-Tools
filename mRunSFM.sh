#!/bin/bash

# Call this script in the current directory where all the images are

# Usage: RunSFM.sh [IMAGES_PER_CLUSTER=100] [CPU_CORES=8] [MAX_MATCHING_SEQ=-1]
# IMAGES_PER_CLUSTER is used by CMVS/PMVS2
# CPU_CORES is used by CMVS/PMVS2
# MAX_MATCHING_SEQ is used by SiftMatcher to limit the number of images to match against, useful if the images were taken sequentially (eg. video) 

# Defaults
IMAGES_PER_CLUSTER=100
CPU_CORES=8
MAX_MATCHING_SEQ=-1
SIFTKEY_CORES=1 # For big images and limited amount of RAM
export PEAK_THRESH=$1

export SIFTKEY_CORES

ARGC=$#  # Number of args, not counting $0

if [ $ARGC -ge 2 ]
then
    IMAGES_PER_CLUSTER=$2
fi

if [ $ARGC -ge 3 ]
then
    CPU_CORES=$3
fi

if [ $ARGC -ge 4 ]
then
    MAX_MATCHING_SEQ=$4
fi

# Make this global, so RunBundler.sh can access it
export MAX_MATCHING_SEQ

BASE_PATH=$(dirname $(which $0));
BUNDLER_PATH=$BASE_PATH
CMVS_PATH=$BASE_PATH/cmvs/program/main

$BUNDLER_PATH/mRunBundler.sh .
$BUNDLER_PATH/bin/Bundle2PMVS list.txt bundle/bundle.out
sed -i '1i\#!/bin/bash' pmvs/prep_pmvs.sh
sed -i '0,/BUNDLER_BIN_PATH=/s//BUNDLER_BIN_PATH=$1/' pmvs/prep_pmvs.sh
chmod +x pmvs/prep_pmvs.sh
./pmvs/prep_pmvs.sh $BUNDLER_PATH/bin
$CMVS_PATH/cmvs pmvs/ $IMAGES_PER_CLUSTER $CPU_CORES
$CMVS_PATH/genOption pmvs/

file=`printf "option-0000"`

if [ -f pmvs/$file ] 
then
	$CMVS_PATH/pmvs2 pmvs/ $file
else
	exit 	
fi

echo "-------------------------------------------"
echo "The models can be found in pmvs/models"
echo 'Enjoy!'
