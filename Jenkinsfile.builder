/*
* Copyright � 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
*
* SPDX-License-Identifier: Apache-2.0
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.                                                            
*
*/

// curl -X POST -F "jenkinsfile=<Jenkinsfile.builder" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def buildAndTest() {
    sh """
    docker-compose config
    docker-compose build --pull --force-rm --no-cache cc
    
    cd templates/sag-spm-config
    docker-compose config
    docker-compose build --force-rm --no-cache
    cd ../..
    
    docker-compose push cc
    """
}

pipeline {
    agent none
    environment {
        // version of the Command Central docker images build/release
        CC_TAG = '10.3'

        // images are from private registry
        CC_SERVER_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-server'
        CC_CLIENT_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-client'
        CC_BUILDER_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder'

        REPO_FIX = 'GA_Fix_Repo'
        REPO_HOST = 'aquarius-bg.eur.ad.sag'
        FIXES = 'ALL'

        // Licenses archive URL to load
        // LICENSES_URL = "http://irepo.eur.ad.sag/projects/DEVOPS/repos/command-central/raw/licenses/sag10-rnd-lnx-licenses.zip?at=refs%2Fheads%2Fmaster"
    }
    stages {
        stage('Build') {
            parallel {
                stage('10.3 SuiteIntCollector') {
                    agent { label 'docker' } 
                    environment {
                        TAG = '10.3-sic'
                        REPO_PRODUCT = '103oct2018_SIC'
                        REPO_FIX = 'QARepo'
                        FIXES = '[]'
                        CC_NODE_IMAGE = "daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node:10.3"
                    }
                    steps {
                        buildAndTest()
                    }
                }
                stage('10.3') {
                    agent { label 'docker' } 
                    environment {
                        TAG = '10.3'
                        REPO_PRODUCT = 'SuiteTest'
                        REPO_FIX = 'GA_Fix_Repo'
                        FIXES = '[]'
                        CC_NODE_IMAGE = "daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node:10.3"
                    }
                    steps {
                        buildAndTest()
                    }
                }
                stage('10.2') {
                    agent { label 'docker' }
                    environment {
                        TAG = '10.2'
                        REPO_PRODUCT = '102apr2018_SIC'
                        CC_NODE_IMAGE = 'daerepository03.eur.ad.sag:4443/softwareag/commandcentral:10.2.0.1.9-node'
                    }
                    steps {
                        buildAndTest()
                    }
                }
                stage('10.1') {
                    agent { label 'docker' }
                    environment {
                        TAG = '10.1'
                        REPO_PRODUCT = '101oct2017_SIC'
                        CC_NODE_IMAGE = 'daerepository03.eur.ad.sag:4443/softwareag/commandcentral:10.1.0.8.141-node'
                    }
                    steps {
                        buildAndTest()
                    }
                }                                                
            }            
        }
    }
}
