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
    environment {
        TAG = "10.3"  // 10.3, 10.2, 10.1
        // FIXES = 'ALL' // for GA releases or '' for TRUNK
    }
    stages {
        stage('Init') {
            steps {
                echo "Testing for ${env.TAG} release"
                sh ". ./${env.TAG}.env; docker-compose pull cc"
            }
        }
        stage("Level 1") {
            parallel {
                // stage('Asset Builder') {
                //     steps {
                //         testTemplate('sag-abe', false, true, true)
                //     }
                // }
                stage('Universal Messaging') {
                    steps {
                        testTemplate('sag-um-server', false, true, true)
                    }
                }
                stage('Terracotta') {
                    steps {
                        testTemplate('sag-tc-server', true, false, false)
                    }
                }
                stage('Integration Server') {
                    steps {
                        testTemplate('sag-msc-server', false, true, true)
                    }
                }                                                
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
