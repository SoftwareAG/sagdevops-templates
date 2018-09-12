/*
* Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
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
    // agent none
    agent { label 'docker' }
    // parameters {
    //     choice(choices: '10.3\n10.2\n10.1', description: 'Release/Tag', name: 'TAG')
    //     choice(choices: 'dev\nprod',        description: 'Environment', name: 'CC_ENV')
    // }
    environment {
        REG = 'daerepository03.eur.ad.sag:4443/ccdevops'
        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
        TAG = '10.3'
        CC_ENV = 'dev'
    }
    stages {
        stage("Infrastructure Images") {
            // agent { label 'docker' }
            steps {
                // checkout scm
                dir ('infrastructure') {
                    sh "docker-compose -f docker-compose.yml -f ${TAG}.staging.yml config"
                    sh "docker-compose -f docker-compose.yml -f ${TAG}.staging.yml build"
                    // sh 'docker-compose push'
                }
            }
        }        
        stage('Build Templates') {
            // agent { label 'docker' }
            steps {
                // checkout scm
                sh "./buildw"
                stash includes: 'build/repo/**', name: 'repo'
                dir ('build/repo') {
                    archive '**'
                }
            }
        }
        stage("Test Templates") {
            parallel {
                stage('Runtimes') {
                    // agent { label 'docker' }
                    steps {
                        // checkout scm
                        // sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        sh './provisionw sag-um-server'
                        // sh "./provisionw sag-um-config"
                        // sh "./provisionw sag-tc-server"
                        // sh "./provisionw sag-is-server"
                        // sh "./provisionw sag-is-config"
                        // sh "./provisionw sag-des"
                        // sh "./provisionw sag-is-cloudstreams"
                        // sh "./provisionw sag-apama-correlator"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                stage('Designer and tools') {
                    // agent { label 'docker' }
                    steps {
                        // sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        // sh "./provisionw sag-msc-server"
                        // sh "./provisionw sag-abe"                        
                        // sh "./provisionw sag-designer-services"
                        // sh "./provisionw sag-designer-cloudstreams"
                        // sh "./provisionw sag-exx-broker"
                        // sh "./provisionw sag-exx-c-rpc-server"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
            }
        }
        stage("Build Images") {
            // agent { label 'docker' }
            steps {
                // checkout scm
                dir ('containers') {
                    sh 'docker-compose config'
                    // sh 'docker-compose pull cc'
                    sh 'docker-compose build universal-messaging'
                    // sh 'docker-compose push'
                }
            }
        }   
        // stage("Build Images") {
        //     agent none

        //     steps {
        //         script {
        //             // def containers = ['sag-um-server', 'sag-is-server', 'sag-tc-server', 'sag-abe']
        //             def containers = ['sag-um-server']
        //             def builders = [:]
        //             for (c in containers) {
        //                 def image = c // Need to bind the label variable before the closure - can't do 'for (label in labels)'
        //                 builders[image] = {
        //                     node('docker') {
        //                         checkout scm
        //                         sh "docker-compose -f templates/$image/docker-compose.yml config"
        //                         sh "docker-compose -f templates/$image/docker-compose.yml build --pull --force-rm"
        //                         sh "docker-compose -f templates/$image/docker-compose.yml push"
        //                     }
        //                 }                        
        //             }
        //             parallel builders // kick off parallel builds    
        //         }
        //     }
        // }

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
