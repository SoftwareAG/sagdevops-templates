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

def testTemplates2(templates) {
    for (t in templates) {
        try {
            sh "./provisionw $t"
        } finally {
            sh "docker-compose down"
        }
    }   
}

def buildAndTestImages(templates) {
    for (t in templates) {
        dir ("templates/$t") {
            sh "docker-compose -f docker-compose-build.yml build"
            sh "docker-compose -f docker-compose-build.yml images"
            try {
                sh "docker-compose -f docker-compose-build.yml run --name $t --rm test"
                sh "docker-compose -f docker-compose-build.yml ps"
                sh "docker-compose -f docker-compose-build.yml push"
            } finally {
                sh "docker-compose -f docker-compose-build.yml logs"
                sh "docker-compose -f docker-compose-build.yml down"
            }
        }
    }   
}

pipeline {
    agent {
        label 'docker'
    }
    environment {
        CC_TAG = '10.3.0.0.7' // fixme: use 10.3
        TAG = '10.3-SuiteTest'
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose up -d --build cc' // build and start the builder
                sh 'docker-compose port cc 8091'
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
                // stage('Integration Server') {
                //     steps {
                //         testTemplates(['sag-msc-server'])
                //     }
                // }                                                
                // stage('Apama') {
                //     steps {
                //         testTemplates(['sag-apama-correlator'])
                //     }
                // }                                                
            }
        }
        stage("Build Images") {
            parallel {
                stage('Universal Messaging') {
                    steps {
                        buildAndTestImages(['sag-um-server'])
                    }
                }
                // stage('Integration Server') {
                //     steps {
                //         buildAndTestImages(['sag-msc-server'])
                //     }
                // }                                                
            }
        }
        stage("Push Images") {
            steps {
                sh 'docker-compose push cc' // upload cc builder
            }
        }
    }
    post {
        // failure {
        //     sh 'docker-compose logs builder'
        // }
        always {
            sh 'docker-compose down'
        }
    }    
}
