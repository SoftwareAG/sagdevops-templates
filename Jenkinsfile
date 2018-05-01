// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplates2(templates) {
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

pipeline {
    agent {
        label 'docker'
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
                        testTemplates2(['sag-um-server'])
                    }
                }
                // stage('Terracotta') {
                //     steps {
                //         testTemplates([])
                //     }
                // }
                stage('Integration Server') {
                    steps {
                        testTemplates2(['sag-msc-server'])
                    }
                }                                                
            }
        }
    }
    post {
        failure {
            sh 'docker-compose logs cc'
        }
        always {
            sh 'docker-compose down'
        }
    }    
}
