// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

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
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Test templates for this release', name: 'release')
    }
    // environment {
    //     TAG = params.release
    // }
    stages {
        stage('Init') {
            steps {
                echo "Testing for ${params.release} release"
                sh ". ./${params.release}.env; docker-compose pull cc"
            }
        }
        stage("Build") {
            environment {
                TAG = "${params.release}"
            }
            parallel {
                stage('Lane 1') {
                    steps {
                        testTemplate('sag-abe', false, true, true)
                    }
                }
                stage('Lane 2') {
                    steps {
                        testTemplate('sag-msc-server', false, true, true)
                        testTemplate('sag-is-server', false, true, true)
                    }
                }
                stage('Lane 3') {
                    steps {
                        testTemplate('sag-um-server', false, true, true)
                        testTemplate('sag-tc-server', false, true, true)
                    }
                }
                // stage('Oracle DB') {
                //     steps {
                //         testTemplate('sag-db-oracle', true, false, false)
                //     }
                // }                                                
            }
        }
        
        // stage("Level 2") {
        //     parallel {
        //         stage('EntireX') {
        //             steps {
        //                 testTemplate('sag-exx-broker', true, false, false)
        //             }
        //         }
        //         stage('Designer') {
        //             steps {
        //                 testTemplate('sag-designer-services', true, false, false)
        //             }
        //         }
        //         stage('Apama') {
        //             steps {
        //                 testTemplate('sag-apama-correlator', true, false, false)
        //             }
        //         }                                                
        //     }
        // }
    }
    post {
        always {
            sh 'docker-compose down'
        }
    }    
}
