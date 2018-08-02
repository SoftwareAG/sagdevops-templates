// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

pipeline {
    agent none
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Test templates for this release', name: 'release')
    }
    stages {
        stage("Test") {
            environment {
                TAG = "${params.release}"
            }
            parallel {
                stage('Inclubator') {
                    agent { label 'docker' }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose -p sagdevops-templates up -d cc'

                        // sh "./provisionw sag-msc-server"
                        // sh "./provisionw sag-abe"
                        // sh "./provisionw sag-designer-cloudstreams"

                        // sh "./provisionw sag-apama-correlator"
                        // sh "./provisionw sag-exx-broker"
                        // sh "./provisionw sag-exx-c-rpc-server"
                    }
                    post {
                        always {
                            sh 'docker-compose -p sagdevops-templates down'
                        }
                    }    
                }
                stage('Stable') {
                    agent { label 'docker' }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose -p sagdevops-templates up -d cc'

                        sh "./provisionw sag-um-server"
                        // sh "./provisionw sag-tc-server"
                        sh "./provisionw sag-is-server"
                        sh "./provisionw sag-des"
                        // sh "./provisionw sag-abe"
                        // sh "./provisionw sag-designer-services"
                    }
                    post {
                        always {
                            sh 'docker-compose -p sagdevops-templates down'
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
