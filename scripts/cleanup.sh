#!/bin/sh
#*******************************************************************************
#  Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

echo "Cleaning up $SAG_HOME ..."
cd $SAG_HOME

echo 'Disk usage before cleaning:'
du -h -d 2

echo "Removing Update Manager but keep metadata (SAGUpdateManager/UpdateManager/profile/p2) ..."
cd SAGUpdateManager && rm -rf bin jvm logs osgi && \
cd UpdateManager && rm -rf bootstrap conf logs readme repository workdata restart_script && \
cd profile && rm -rf *.xml *.ini configuration plugins && \
cd $SAG_HOME

echo "Removing Installer but keep install/products metadata ..."
rm -fr install/repo install/logs install/jars install/bpms install/etc
rm -f sagProducts.xml sagMetadata.xml p2.index

echo "Removing Licenses and doc ..."
rm -fr Licenses/ _documentation/

echo "Removing log files ..."
rm -f `find ./ -name *.log`

echo "Removing Common ..."
# rm -rf common/db/
# rm -rf common/runtime/install/
# rm -rf common/runtime/agent/

echo "Removing Java ..."
rm -fr jvm/

echo 'Disk usage after cleaning:'
du -h -d 2
