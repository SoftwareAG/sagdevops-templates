// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

pipeline {
    agent none
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Test templates for this release', name: 'release')
        choice(choices: '[]\nALL', description: 'Fixes to install', name: 'fixes')
    }
    stages {
        stage("Test") {
            environment {
                TAG = "${params.release}"
            }
            parallel {
                stage('Stable') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -d cc'

                        sh "./provisionw sag-um-server um.fixes=${params.fixes}"
                        sh "./provisionw sag-um-config um.url=nsp://node:9000"
                        sh "./provisionw sag-tc-server tc.fixes=${params.fixes}"
                        sh "./provisionw sag-is-server is.fixes=${params.fixes}"
                        sh "./provisionw sag-is-config is.um.url=nsp://node:9000"
                        sh "./provisionw sag-des des.fixes=${params.fixes} des.um.url=nsp://node:9000"

                        sh "./provisionw sag-abe abe.fixes=${params.fixes}"
                        
                        sh "./provisionw sag-designer-services designer.fixes=${params.fixes}"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                stage('Incubator') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -d cc'

                        sh "./provisionw sag-msc-server is.fixes=${params.fixes}"
                        sh "./provisionw sag-cloudstreams cst.fixes=${params.fixes}"
                        sh "./provisionw sag-designer-cloudstreams designer.fixes=${params.fixes}"

                        sh "./provisionw sag-apama-correlator apama.fixes=${params.fixes}"
                        sh "./provisionw sag-exx-broker exx.broker.fixes=${params.fixes}"
                        sh "./provisionw sag-exx-c-rpc-server exx.server.fixes=${params.fixes}"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                // stage('Failing') {
                //     agent { label 'docker' }
                //     steps {
                //         sh 'docker-compose pull cc'
                //         sh 'docker-compose -p sagdevops-templates up -d cc'

                //         // provision 'sag-db-oracle'
                //         // provision 'sag-db-sqlserver'
                //         // provision 'sag-mws-server'
                //     }
                //     post {
                //         always {
                //             sh 'docker-compose -p sagdevops-templates down'
                //         }
                //     }    
                // }
            }
        }
    }
}
