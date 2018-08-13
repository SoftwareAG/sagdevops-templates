#!/bin/sh -e
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

# if managed image
if [ -d $SAG_HOME/profiles/SPM ] ; then
    # point to local SPM
    export CC_SERVER=http://localhost:8092/spm

    echo "Verifying managed container $CC_SERVER ..."
    sagcc get inventory products -e NINJA --wait-for-cc

    export CC_WAIT=60
    # echo "Verifying fixes ..."
    # sagcc get inventory fixes -e wMFix.NINJA

    echo "Verifying instances ..."
    sagcc get inventory components -e OSGI-NINJA_default

    echo "Start the instance ..."
    sagcc exec lifecycle components OSGI-NINJA_default start  -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus OSGI-NINJA_default -e ONLINE -w 60

    echo "Verifying configs ..."
    sagcc get configuration data OSGI-NINJA_default COMMON-MEMORY -e 256
fi

echo "Verifying product runtime ..."
curl http://localhost:4444/ | grep "Welcome to Software AG Spring Board" || exit 1

echo "TEST SUCCESSULL"
