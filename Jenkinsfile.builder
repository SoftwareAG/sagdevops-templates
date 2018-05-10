// curl -X POST -F "jenkinsfile=<Jenkinsfile.builder" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplate(t, testProvision, buildImage, pushImage) {
    dir ("templates/$t") {
        try {
            if (testProvision) {
                sh "docker-compose run --name $t --rm provision"
            }
            if (buildImage) {
                sh "docker-compose build"
                if (pushImage) {
                    sh "docker-compose push"
                }
            }
        } finally {
            sh "docker-compose down"
        }
    }
}

pipeline {
    agent {
        label 'docker'
    }
    environment {
        CC_TAG = '10.3'
    }
    stages {
        stage('Build') {
            parallel {
                stage('10.3') {
                    steps {
                        sh 'source 10.3.env; docker-compose build cc'
                    }
                }
                stage('10.2') {
                    steps {
                        sh 'source 10.2.env; docker-compose build cc'
                    }
                }
                stage('10.1') {
                    steps {
                        sh 'source 10.3.env; docker-compose build cc'
                    }
                }                                                
            }            
        }
        stage("Test") {
            parallel {
                // stage('jenkins') {
                //     steps {
                //         testTemplate('jenkins', true)
                //     }
                // }
                stage('sag-spm-connect') {
                    steps {
                        testTemplate('sag-spm-connect', true)
                    }
                }
                stage('sag-spm-config') {
                    steps {
                        testTemplate('sag-spm-config', false, true, false)
                    }
                }
            }
        }
        stage("Push") {
            parallel {
                stage('10.3') {
                    steps {
                        sh 'source 10.3.env; docker-compose push cc'
                    }
                }
                stage('10.2') {
                    steps {
                        sh 'source 10.2.env; docker-compose push cc'
                    }
                }
                stage('10.1') {
                    steps {
                        sh 'source 10.3.env; docker-compose push cc'
                    }
                }                                                
            }            
        }
    }
    post {
        always {
            sh 'docker-compose down'
        }
    }    
}
