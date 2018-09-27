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

if [ -f $SAG_HOME/register.sh ]; then
    $SAG_HOME/register.sh
fi

# you can simply run main product run in foreground
# $SAG_HOME/profiles/IS_$INSTANCE_NAME/bin/console.sh
# or do this...

IS_INSTANCE_NAME=${IS_INSTANCE_NAME:-default}

# echo "Remove old logs"
# rm -rf $SAG_HOME/profiles/IS_$IS_INSTANCE_NAME/logs/*.log

# or can start in background
$SAG_HOME/profiles/IS_$IS_INSTANCE_NAME/bin/startup.sh

echo "IS process started. Waiting ..."
# wait until IS server.log comes up
while [  ! -f $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log ]; do
    # tail $SAG_HOME/profiles/IS_$INSTANCE_NAME/logs/wrapper.log
    sleep 5
done

echo "IS process successfully started. Waiting for HTTP stack ..."
until curl -u Administrator:manage -s http://`hostname`:5555/ 
do 
    sleep 5
    tail $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log
done

# this is our main container process

echo "Integration Server is ONLINE at http://`hostname`:5555/"

tail -f $SAG_HOME/IntegrationServer/instances/$IS_INSTANCE_NAME/logs/server.log
