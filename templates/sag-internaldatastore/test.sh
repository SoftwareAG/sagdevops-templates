#!/bin/sh -e
#*******************************************************************************
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container ..."
    sagcc get inventory products -e CEL --wait-for-cc

    export CC_WAIT=180
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes
    # -e wMFix.CEL

    echo "Verifying instances ..."
    sagcc get inventory components -e CEL

    echo "Start the instance ..."
    sagcc exec lifecycle components CEL start -e DONE --sync-job

	echo "tailing logs"
	sagcc get diagnostics logs CEL SAG_EventDataStore.log tail lines=100 -e initialized
	
    echo "Verifying status ..."
    sagcc get monitoring runtimestatus CEL -e ONLINE

fi

echo "Verifying product runtime ..."
echo "Verifying Internal Data Store..."
curl -u Administrator:manage -s http://`hostname`:9240/
echo "DONE testing"
