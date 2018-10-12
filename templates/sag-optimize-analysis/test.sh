#!/bin/sh -e
#*******************************************************************************
#  Copyright пїЅ 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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
    sagcc get inventory products -e SPM --wait-for-cc

    export CC_WAIT=60
    
    echo "Verifying fixes ..."
    sagcc get inventory fixes 

    echo "Verifying instances ..."
    sagcc get inventory components -e optimizeAnalysis-analysis

    echo "Start the instance ..."
    sagcc exec lifecycle components optimizeAnalysis-analysis start -e DONE --sync-job

    echo "Verifying status ..."
    sagcc get monitoring runtimestatus optimizeAnalysis-analysis -e ONLINE

    echo "Verifying configs ..."
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-COMPONENT-ENDPOINTS-JMS-Provider -e JMS-Provider
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-COMPONENT-ENDPOINTS-Configuration-Agent -e Configuration-Agent
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-COMPONENT-ENDPOINTS-MWS -e MWS
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-COMPONENT-ENDPOINTS-WS-Registry -e WS-Registry

    sagcc get configuration instances optimizeAnalysis-analysis COMMON-JDBC-webmdb -e webmdb

    sagcc get configuration instances optimizeAnalysis-analysis COMMON-DBFUNCTION-AnalysisEngine -e AnalysisEngine
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-DBFUNCTION-CommonDirectory -e CommonDirectory
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-DBFUNCTION-ProcessHistory -e ProcessHistory
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-DBFUNCTION-ProcessModel -e ProcessModel
    sagcc get configuration instances optimizeAnalysis-analysis COMMON-DBFUNCTION-ProcessWork -e ProcessWork

fi

echo "Verifying product runtime ..."
curl -H Accept:text http://localhost:12503/services/mapivalidation.wsdl

echo "TEST SUCCESSFUL"
