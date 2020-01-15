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

TEMPLATE=$1
ASSET_REPO_FOLDER=/tmp/abe
ASSET_SOURCE_TEMP_FOLDER=/tmp/abe/source
ASSET_SOURCE_TEMP_FOLDER_TEMPLATE=/tmp/abe/source/$TEMPLATE
ASSET_SOURCE_FOLDER=/opt/sagtools/profiles/CCE/data/templates/composite/

ABE_HOME=/opt/softwareag/common/AssetBuildEnvironment/CC
# export GIT_USER={secured}
# export GIT_PUBLISH_KEY={secured}

rm -rf $ASSET_REPO_FOLDER
mkdir -p $ASSET_REPO_FOLDER
rm -rf $ASSET_SOURCE_TEMP_FOLDER
mkdir -p $ASSET_SOURCE_TEMP_FOLDER_TEMPLATE
cp $ASSET_SOURCE_FOLDER/$TEMPLATE/template.yaml $ASSET_SOURCE_TEMP_FOLDER_TEMPLATE
cp $ASSET_SOURCE_FOLDER/$TEMPLATE/*.jar $ASSET_SOURCE_TEMP_FOLDER_TEMPLATE

#mv $ASSET_SOURCE_TEMP_FOLDER/template.yaml $ASSET_SOURCE_TEMP_FOLDER/template.yaml

##debug
echo building asset for template $TEMPLATE


cd $ASSET_REPO_FOLDER
git clone https://github.com/SoftwareAG/sagdevops-templates-repo.git
cd sagdevops-templates-repo
git config credential.helper '!f() { sleep 1; echo "username=${GIT_USER}"; echo "password=${GIT_PUBLISH_KEY}"; }; f'
 git config --global user.email "you@example.com"
 git config --global user.name "Your Name"

cd $ABE_HOME
ant -v -Dbuild.source.dir=$ASSET_SOURCE_TEMP_FOLDER -Dbuild.output.dir=$ASSET_REPO_FOLDER/sagdevops-templates-repo
if [ $? -eq 0 ]
then
     echo "debug env variables"
     env
     if [ "$TRAVIS_PULL_REQUEST" != "false" ]
     then
        cd $ASSET_REPO_FOLDER/sagdevops-templates-repo
        git add CC/*
        git commit -m "PR $TRAVIS_PULL_REQUEST for $TEMPLATE"
        git push
        echo "Asset for template $TEMPLATE built and pushed to https://github.com/SoftwareAG/sagdevops-templates-repo "
     else
        echo "skipping push to github repo, because it is not a pull request"
     fi
else
        echo asset failed to be built from template $TEMPLATE 
        exit 1
fi

