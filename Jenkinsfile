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
            sh "docker-compose run --name $t --rm -e CC_TEMPLATE=$t test antc clean"
        }       
    }   
}

pipeline {
    agent {
        label 'docker'
    }
    // options {
    //     buildDiscarder(logRotator(numToKeepStr:'10'))
    //     disableConcurrentBuilds()
    // }
    environment {
        SAG_AQUARIUS = 'aquarius-bg.eur.ad.sag'
        EMPOWER = credentials('empower')
        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose pull'
                sh 'docker-compose run --rm initcc'
            }
        }
        stage("Test") {
            parallel {
                stage('Command Central') {
                    steps {
                        testTemplates(['sag-creds', 'sag-repos', 'sag-cc-tuneup'])
                    }
                }
                stage('Jenkins') {
                    steps {
                        testTemplates(['jenkins'])
                    }
                }
                stage('Universal Messaging') {
                    steps {
                        testTemplates(['sag-um-server'])
                    }
                }
                stage('Terracotta') {
                    steps {
                        testTemplates([])
                    }
                }
                stage('Integration Server') {
                    steps {
                        testTemplates([])
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
