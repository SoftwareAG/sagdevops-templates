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
    agent { label 'docker' }
    parameters {
        booleanParam(name: 'INFRA',  defaultValue: false, description: 'Force build and push infrastructure')
        booleanParam(name: 'TEST',   defaultValue: false, description: 'Force test all templates')
        booleanParam(name: 'BUILD',  defaultValue: false, description: 'Force build and push product images')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Force deploy to staging environment')
        
        choice(name: 'CC_TAG', choices: '10.3\n10.4',       description: 'Command Central core tag')
        choice(name: 'TAG',    choices: '10.3\n10.4\n10.1', description: 'Product release tag')
        choice(name: 'FIXES',  choices: 'ALL\n[]',          description: 'ALL or no fixes')
        choice(name: 'STAGE',  choices: 'staging\nmaster',  description: 'Upstream repos location (AQU, EMPOWER)')
    }
    environment {
        REG = 'daerepository03.eur.ad.sag:4443/sagdevops'    // target registry/org for product images
        REPO_HOST = 'aquarius-bg.eur.ad.sag'                 // product repos on
        CC_REG = 'daerepository03.eur.ad.sag:4443/ccdevops'  // source registry/org for CC core images
        CC_INSTALLER_URL = 'http://aquarius-bg.eur.ad.sag/cc/installers' // installers on
        EMPOWER = credentials('empower')
        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
    }
    stages {
        stage("Infrastructure Images") {
            when {
                anyOf {
                    expression { return params.INFRA }
                    changeset "infrastructure/**" 
                } 
            }
            steps {
                dir ('infrastructure') {
                    sh "docker-compose -f docker-compose.yml -f ${STAGE}.yml -f ${TAG}.${STAGE}.yml config"
                    sh "docker-compose -f docker-compose.yml -f ${STAGE}.yml -f ${TAG}.${STAGE}.yml build --pull"
                }

                echo 'Testing infrastructure images with Hello World template ...'
                sh './provisionw hello-world'
                sh 'docker-compose down'

                echo 'Testing infrastructure images with Hello World container ...'
                dir ('containers') {
                    sh 'docker-compose config'
                    sh 'docker-compose build --no-cache --force-rm hello-world'
                }

                echo 'Pushing infrastructure images ...'
                dir ('infrastructure') {
                    sh "docker-compose -f docker-compose.yml -f ${STAGE}.yml -f ${TAG}.${STAGE}.yml push"
                }
            }
        }
        stage("Test Templates") {
            when {
                anyOf {
                    expression { return params.TEST }
                    changeset "templates/**" 
                } 
            }
            parallel {
                // stage('Group Oracle') {
                //     agent { label 'docker' }
                //     environment {
                //         CC_ENV = 'oracle'
                //     }
                //     steps {
                //         sh 'docker-compose up -V -d --remove-orphans cc'
                //         sh 'docker-compose -f templates/sag-db-oracle/docker-compose.yml up -d oracle'
                //         sh './provisionw sag-db-oracle'
                //     }
                //     post {
                //         always {
                //             sh 'docker-compose -f templates/sag-db-oracle/docker-compose.yml down'
                //             sh 'docker-compose down'
                //         }
                //     }    
                // }
                // stage('Group SQLServer') {
                //     agent { label 'docker' }
                //     environment {
                //         CC_ENV = 'sqlserver'
                //     }
                //     steps {
                //         sh 'docker-compose up -V -d --remove-orphans cc'
                //         sh 'docker-compose -f templates/sag-db-sqlserver/docker-compose.yml up -d sqlserver'
                //         sh './provisionw sag-db-sqlserver'
                //     }
                //     post {
                //         always {
                //             sh 'docker-compose -f templates/sag-db-sqlserver/docker-compose.yml down'
                //             sh 'docker-compose down'
                //         }
                //     }    
                // }
                stage('Group Core') {
                    agent { label 'docker' }
                    environment {
                        CC_ENV = 'dev'
                    }
                    steps {
                        // checkout scm
                        // sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d --remove-orphans cc'

                        sh './provisionw sag-um-server'
                        sh './provisionw sag-um-config'
                        sh './provisionw sag-tc-server'
                        // sh './provisionw sag-tdb-server'
                        sh './provisionw sag-is-server'
                        sh './provisionw sag-is-config'
                        // sh './provisionw sag-des'
                        // sh './provisionw sag-des-config'
                        // sh './provisionw sag-apama-correlator'
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                // stage('Group 2') {
                //     agent { label 'docker' }
                //     environment {
                //         CC_ENV = 'dev'
                //     }
                //     steps {
                //         // sh 'docker-compose pull cc'
                //         sh 'docker-compose up -V -d --remove-orphans cc'

                //         sh './provisionw sag-abe'                       
                //         sh "./provisionw sag-msc-server"
                //         sh './provisionw sag-is-cloudstreams'
                //         sh './provisionw sag-designer-services'
                //         sh './provisionw sag-designer-cloudstreams'
                //         sh './provisionw sag-exx-broker'
                //         sh './provisionw sag-exx-c-rpc-server'
                //         sh './provisionw sag-exx-java-rpc-server'
                //         sh './provisionw sag-exx-xml-rpc-server'
                //         sh './provisionw sag-infradc'
                //         // sh './provisionw sag-onedata'
                //     }
                //     post {
                //         always {
                //             sh 'docker-compose down'
                //         }
                //     }    
                // }
            }
        }
        stage("Build Images") {
            when {
                anyOf {
                    expression { return params.BUILD }
                    changeset "containers/**" 
                } 
            }
            parallel {
                stage('Group Core') {
                    agent { label 'docker' }
                    steps {
                        dir ('containers') {
                            sh 'docker-compose config'
                            sh 'docker-compose build --no-cache --force-rm universal-messaging integration-server'
                            sh 'docker-compose push universal-messaging integration-server'
                        }
                    }
                }
                // stage('Group 2') {
                //     agent { label 'docker' }
                //     steps {
                //         dir ('containers') {
                //             sh 'docker-compose config'
                //             sh 'docker-compose build --no-cache --force-rm asset-builder microservices-runtime cloud-streams'
                //             sh 'docker-compose push asset-builder microservices-runtime cloud-streams'
                //         }
                //     }
                // }
                // stage('Group 3') {
                //     agent { label 'docker' }
                //     steps {
                //         dir ('containers') {
                //             sh 'docker-compose config'
                //             sh 'docker-compose build --no-cache --force-rm entirex-broker entirex-java-rpc-server entirex-xml-rpc-server'
                //             sh 'docker-compose push entirex-broker entirex-java-rpc-server entirex-xml-rpc-server'
                //         }
                //     }
                // }
            }
        }   
        stage("Deploy") {
            when {
                anyOf {
                    expression { return params.DEPLOY }
                    changeset "containers/**" 
                } 
            }
            steps {
                build job: 'cc-docker-staging', parameters: [string(name: 'CC_TAG', value: "$CC_TAG"), string(name: 'TAG', value: "$TAG"), booleanParam(name: 'INFRA', value: true), booleanParam(name: 'STACKS', value: true)], propagate: true, wait: true
            }
        }   
        // stage('Publish Templates') {
            // when {
            //     anyOf {
            //         expression { return params.BUILD }
            //         changeset "containers/**" 
            //     } 
            // }
        //     steps {
        //         sh 'docker-compose run --rm build'
        //         dir ('build/repo') {
        //             archiveArtifacts '**'
        //             git branch: 'master', url: 'http://irepo.eur.ad.sag/scm/devops/assets-templates-repo.git'
        //             sh """
        //             git add --all
        //             git commit -m 'Jenkins'
        //             git push
        //             """
        //         }
        //     }
        // }
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
    }  
}
