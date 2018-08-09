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
// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

pipeline {
    agent none
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Release', name: 'release')
        choice(choices: 'dev\nprod',        description: 'Environment', name: 'env')
    }
    stages {
        stage('Build') {
            agent { label 'docker' }
            environment {
                COMPOSE_PROJECT_NAME = 'sagdevops-templates'
            }
            steps {
                sh "./buildw"
                stash includes: 'build/repo/**', name: 'repo'
                dir ('build/repo') {
                    archive '**'
                    //deleteDir()
                }
            }
        }
        stage("Test") {
            environment {
                TAG = "${params.release}"
                CC_ENV = "${params.env}" // Use ./environments/$CC_ENV/env.properties
            }
            parallel {
                stage('Runtimes') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                        
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        sh "./provisionw sag-um-server"
                        sh "./provisionw sag-um-config"
                        sh "./provisionw sag-tc-server"
                        sh "./provisionw sag-is-server"
                        sh "./provisionw sag-is-config"
                        sh "./provisionw sag-des"
                        sh "./provisionw sag-is-cloudstreams"
                        sh "./provisionw sag-apama-correlator"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                stage('Designer and tools') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                        CC_ENV = 'dev'
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        sh "./provisionw sag-msc-server"
                        sh "./provisionw sag-abe"                        
                        sh "./provisionw sag-designer-services"
                        sh "./provisionw sag-designer-cloudstreams"
                        sh "./provisionw sag-exx-broker"
                        sh "./provisionw sag-exx-c-rpc-server"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
            }
        }

        // stage('Publish') {
        //     agent { label 'docker' }
        //     environment {
        //         COMPOSE_PROJECT_NAME = 'sagdevops-templates'
        //     }
        //     steps {
        //         dir ('build/repo') {
        //             git branch: 'master', url: 'http://irepo.eur.ad.sag/scm/devops/assets-templates-repo.git'
        //         }
        //         unstash 'repo'
        //         dir ('build/repo') {
        //             sh """
        //             git add --all
        //             git commit -m 'Jenkins'
        //             git push
        //             """
        //         }
        //     }
        // }
    }
}
