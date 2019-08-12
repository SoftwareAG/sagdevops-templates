#!/bin/bash

if [ $# -ne 1 ]
then
	echo Usage: "assetGenerate.sh <template-name>"
	exit 1
fi

ASSET_REPO_FOLDER=/tmp/abe
ASSET_SOURCE_TEMP_FOLDER=/tmp/abe/source
ASSET_SOURCE_FOLDER=/opt/sagtools/profiles/CCE/data/templates/composite/
TEMPLATE=$1
ABE_HOME=/opt/softwareag/common/AssetBuildEnvironment/CC
# export GIT_USER={secured}
# export GIT_PUBLISH_KEY={secured}

rm -rf $ASSET_REPO_FOLDER
mkdir -p $ASSET_REPO_FOLDER
rm -rf $ASSET_SOURCE_TEMP_FOLDER
mkdir -p $ASSET_SOURCE_TEMP_FOLDER
cp $ASSET_SOURCE_FOLDER/$TEMPLATE/* $ASSET_SOURCE_TEMP_FOLDER
mv $ASSET_SOURCE_TEMP_FOLDER/template.yaml $ASSET_SOURCE_TEMP_FOLDER/$TEMPLATE.yaml

cd $ASSET_REPO_FOLDER
git clone https://github.com/SoftwareAG/sagdevops-templates-repo.git
cd sagdevops-templates-repo
git config credential.helper '!f() { sleep 1; echo "username=${GIT_USER}"; echo "password=${GIT_PUBLISH_KEY}"; }; f'

cd $ABE_HOME
ant -v -Dbuild.source.dir=$ASSET_SOURCE_TEMP_FOLDER -Dbuild.output.dir=$ASSET_REPO_FOLDER/sagdevops-templates-repo
if [ $? -eq 0 ]
then
        cd $ASSET_REPO_FOLDER/sagdevops-templates-repo
        git add CC/*
        git commit -m "test build of asset for template $TEMPLATE"
        git push
else
        echo asset failed to be built from template $TEMPLATE
        exit 1
fi

