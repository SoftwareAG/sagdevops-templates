// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplates(templates) {
    for (t in templates) {
        dir ("templates/$t") {
            try {
                sh "docker-compose run --name $t --rm provision"
                sh "docker-compose ps"
            } finally {
                sh "docker-compose logs"
                sh "docker-compose down"
            }
        }
    }   
}

def buildAndTestImages(templates) {
    for (t in templates) {
        dir ("templates/$t") {
            sh "docker-compose build"
            sh "docker-compose images"
            try {
                sh "docker-compose run --name $t --rm test"
                sh "docker-compose ps"
                sh "docker-compose push"
            } finally {
                sh "docker-compose logs"
                sh "docker-compose down"
            }
        }
    }   
}

pipeline {
    agent {
        label 'docker'
    }
    environment {
        TAG = '10.3.0.0.3'
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose up -d --build builder' // build and start the builder
                //sh 'docker-compose up -d cc'
                //sh 'docker-compose port cc 8091'
            }
        }
        stage("Test") {
            parallel {
                // stage('Command Central') {
                //     steps {
                //         testTemplates(['sag-creds', 'sag-repos', 'sag-cc-tuneup'])
                //     }
                // }
                // stage('Jenkins') {
                //     steps {
                //         testTemplates(['jenkins'])
                //     }
                // }
                stage('Universal Messaging') {
                    steps {
                        testTemplates(['sag-um-server'])
                    }
                }
                // stage('Terracotta') {
                //     steps {
                //         testTemplates([])
                //     }
                // }
                stage('Integration Server') {
                    steps {
                        testTemplates(['sag-msc-server'])
                    }
                }                                                
                stage('Apama') {
                    steps {
                        testTemplates(['sag-apama-correlator'])
                    }
                }                                                
            }
        }
        stage("Build Images") {
            parallel {
                stage('Universal Messaging') {
                    steps {
                        buildAndTestImages(['sag-um-server'])
                    }
                }
                stage('Integration Server') {
                    steps {
                        buildAndTestImages(['sag-msc-server'])
                    }
                }                                                
            }
        }
    }
    post {
        failure {
            sh 'docker-compose logs builder'
        }
        always {
            sh 'docker-compose down'
        }
    }    
}
