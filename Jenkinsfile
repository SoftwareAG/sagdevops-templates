// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def testTemplates(templates) {
    for (t in templates) {
        // do we have custom docker-componse.yml ?
        boolean customEnv = fileExists("templates/$t/docker-compose.yml")
        
        try {
            // init the env
            if (customEnv) {
                dir("templates/$t") {
                    sh "docker-compose -p $t run --name $t-env --rm -e CC_TEMPLATE=$t init"
                }
            }
            
            sh "docker-compose run --name $t --rm -e CC_TEMPLATE=$t test"
            
            junit "build/tests/**/*.xml"
            archive "build/templates/${t}.zip"
        }
        catch (err) {
            // capture logs
            if (customEnv) {
                dir("templates/$t") {
                    sh "docker-compose -p $t logs"
                }
            }        
        } finally {
            // down the env
            if (customEnv) {
                dir("templates/$t") {
                    sh "docker-compose -p $t down"
                }
            }        

            // cleanup build/ files
            // sh "docker-compose run --name $t --rm -e CC_TEMPLATE=$t test antcc clean"
        }       
    }   
}

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
    environment {
        RELEASE = '10.2'    // MUST match the release
        TAG = "10.2.0.1.31" // All images tag      
        
        SAG_AQUARIUS = 'aquarius-bg.eur.ad.sag'
        EMPOWER = credentials('empower')
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose up -d cc'
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
                        testTemplates2(['sag-um-server'])
                    }
                }
                // stage('Terracotta') {
                //     steps {
                //         testTemplates([])
                //     }
                // }
                // stage('Integration Server') {
                //     steps {
                //         testTemplates(['sag-is-server'])
                //     }
                // }                                                
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
