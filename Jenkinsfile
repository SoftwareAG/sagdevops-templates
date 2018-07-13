// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplate(t, testProvision, buildImage, pushImage) {
    try {
        if (testProvision) {
            sh "docker-compose -f templates/$t/docker-compose.yml run --name $t --rm provision"
        }
        if (buildImage) {
            sh "docker-compose -f templates/$t/docker-compose.yml build"
            if (pushImage) {
                sh "docker-compose -f templates/$t/docker-compose.yml push"
            }
        }
    } finally {
        sh "docker-compose -f templates/$t/docker-compose.yml down"
    }
}

pipeline {
    agent none
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Test templates for this release', name: 'release')
    }
    stages {
        stage("Build") {
            environment {
                TAG = "${params.release}"
            }
            parallel {
                stage('Lane 1') {
                    agent { label 'docker' }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose -p sagdevops-templates up -d cc'
                        testTemplate('sag-db-oracle', true, false, false)
                        testTemplate('sag-mws-server', true, false, false)
                    }
                    post {
                        always {
                            sh 'docker-compose -p sagdevops-templates down'
                        }
                    }    
                }
                stage('Lane 2') {
                    agent { label 'docker' }
                    steps {
                        sh 'docker-compose pull cc'
                        testTemplate('sag-um-server', false, true, true)
                        testTemplate('sag-tc-server', false, true, true)
                        testTemplate('sag-msc-server', false, true, true)
                        testTemplate('sag-is-server', false, true, true)
                        testTemplate('sag-abe', false, true, true)
                    }
                    post {
                        always {
                            sh 'docker-compose -p sagdevops-templates down'
                        }
                    }    
                }
                stage('Lane 3') {
                    agent { label 'docker' }
                    steps {
                        sh 'docker-compose pull cc'
                        testTemplate('sag-designer-services', true, false, false)
                        testTemplate('sag-apama-correlator', true, false, false)
                        // testTemplate('sag-exx-broker', false, true, false)
                        // testTemplate('sag-exx-c-rpc-server', false, true, false)
                    }
                    post {
                        always {
                            sh 'docker-compose -p sagdevops-templates down'
                        }
                    }    
                }
            }
        }
    }
}
