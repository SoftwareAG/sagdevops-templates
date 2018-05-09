// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplate(t) {
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

def testTemplates(templates) {
    for (t in templates) {
        testTemplate(t)
    }   
}

def buildImage(t) {
    dir ("templates/$t") {
        sh "docker-compose -f docker-compose-build.yml build"
        try {
            sh "docker-compose -f docker-compose-build.yml run --name $t --rm test"
            sh "docker-compose -f docker-compose-build.yml push"
        } finally {
            sh "docker-compose -f docker-compose-build.yml logs"
            sh "docker-compose -f docker-compose-build.yml down"
        }
    }
}

def buildImages(templates) {
    for (t in templates) {
        buildImage(t)
    }   
}

pipeline {
    agent {
        label 'docker'
    }
    environment {
        CC_TAG = '10.3'
        TAG = "10.3"
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose pull cc' // build and start the builder
                //sh 'docker-compose up -d --build cc' // build and start the builder
                //sh 'docker-compose port cc 8091'
            }
        }
        stage("Test 1") {
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
                        //testTemplates(['sag-um-server'])
                        buildImages(['sag-um-server'])
                    }
                }
                stage('Terracotta') {
                    steps {
                        testTemplates(['sag-tc-server'])
                    }
                }
                stage('Integration Server') {
                    steps {
                        //testTemplates(['sag-msc-server'])
                        buildImages(['sag-msc-server'])
                    }
                }                                                
            }
        }
        stage("Test 2") {
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
                stage('EntireX') {
                    steps {
                        testTemplates(['sag-exx-broker'])
                    }
                }
                stage('Designer') {
                    steps {
                        testTemplates(['sag-designer-services'])
                    }
                }
                stage('Apama') {
                    steps {
                        testTemplates(['sag-apama-correlator'])
                    }
                }                                                
            }
        }
        stage("Push Images") {
            steps {
                sh 'docker-compose push cc' // upload cc builder
            }
        }
    }
    post {
        always {
            sh 'docker-compose down'
        }
    }    
}
