// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplate(t) {
    try {
        sh "docker-compose -f templates/$t/docker-compose.yml run --name $t --rm provision"
    } finally {
        sh "docker-compose -f templates/$t/docker-compose.yml down"
    }
}

def provision(t, params) {
    sh "./provisionw $t $params"
}

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

                        provision('sag-msc-server')
                        provision('sag-abe')
                        provision('sag-designer-cloudstreams')

                        provision('sag-apama-correlator')
                        provision('sag-exx-broker')
                        provision('sag-exx-c-rpc-server')
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

                        provision ('sag-um-server')
                        provision ('sag-tc-server')
                        provision ('sag-is-server')
                        provision ('sag-des')
                        
                        provision ('sag-designer-services')
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
