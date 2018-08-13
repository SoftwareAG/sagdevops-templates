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

###
# default entrypoint script
###

$SAG_HOME/register.sh

echo "SPM process started. Waiting for services ..."
# wait until default.log comes up
while [  ! -f $SAG_HOME/profiles/SPM/logs/default.log ]; do
    tail $SAG_HOME/profiles/SPM/logs/wrapper.log
    sleep 5
done

echo "Waiting for SPM ..."
until curl -s http://`hostname`:8092/ 
do 
    sleep 5
done

echo "SPM is ONLINE at http://`hostname`:8092/spm"

# echo "Starting managed runtimes ..."
# sagcc exec lifecycle components OSGI-NINJA_default start -e DONE --sync-job -s http://`hostname`:8092/spm

# this is our main container process
tail -f $SAG_HOME/profiles/SPM/logs/default.log
