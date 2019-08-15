#!/bin/sh
#*******************************************************************************
#  Copyright  2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
#*******************************************************************************
 
if [ $# -ne 1 ]
then
        echo Usage: "generateAsset.sh <template-name>"
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
##debug
echo list of environment vars
echo $TEMPLATE
echo $ASSET_REPO_FOLDER
echo  $ASSET_SOURCE_TEMP_FOLDER
echo the template is $TEMPLATE
echo the original template file is `ls -l $ASSET_SOURCE_FOLDER/$TEMPLATE/` in  $ASSET_SOURCE_FOLDER/$TEMPLATE
echo moved file is `ls -la  $ASSET_SOURCE_TEMP_FOLDER/$TEMPLATE.yaml` in $ASSET_SOURCE_TEMP_FOLDER


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
        echo "Asset for template $TEMPLATE built and pushed to https://github.com/SoftwareAG/sagdevops-templates-repo"
else
        echo asset failed to be built from template $TEMPLATE 
        exit 1
fi

