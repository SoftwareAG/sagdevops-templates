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
export CC_SERVER=http://localhost:8092/spm

echo "Verifying managed container $CC_SERVER ..."
sagcc get inventory products -e SPM --wait-for-cc

export CC_WAIT=5
echo "Verifying fixes ..."
sagcc get inventory fixes 

echo "Verifying instances ..."
sagcc get inventory components -e optimizeWSDataCollector-dataCollector

echo "Verifying configs ..."
sagcc get configuration instances optimizeWSDataCollector-dataCollector COMMON-COMPONENT-ENDPOINTS-JMS-Provider -e JMS-Provider
sagcc get configuration instances optimizeWSDataCollector-dataCollector COMMON-COMPONENT-ENDPOINTS-Configuration-Agent -e Configuration-Agent
sagcc get configuration instances optimizeWSDataCollector-dataCollector COMMON-COMPONENT-ENDPOINTS-WS-Registry -e WS-Registry

echo "Verifying status ..."
sagcc get monitoring runtimestatus optimizeWSDataCollector-dataCollector -e ONLINE

echo "Verifying product runtime ..."
curl -H Accept:text http://localhost:12603/services/WSProcessDataCollector.wsdl

echo "DONE testing"
