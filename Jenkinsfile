// curl -X POST -F "jenkinsfile=<Jenkinsfile" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

pipeline {
    agent none
    parameters {
        choice(choices: '10.3\n10.2\n10.1', description: 'Release', name: 'release')
        choice(choices: 'dev\nprod',        description: 'Environment', name: 'env')
    }
    stages {
        stage('Build') {
            agent { label 'docker' }
            environment {
                COMPOSE_PROJECT_NAME = 'sagdevops-templates'
            }
            steps {
                sh './buildw'
            }
        }
        stage("Test") {
            environment {
                TAG = "${params.release}"
                CC_ENV = "${params.env}" // Use ./environments/$CC_ENV/env.properties
            }
            parallel {
                stage('Runtimes') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                        
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        sh "./provisionw sag-um-server"
                        sh "./provisionw sag-um-config"
                        sh "./provisionw sag-tc-server"
                        sh "./provisionw sag-is-server"
                        sh "./provisionw sag-is-config"
                        sh "./provisionw sag-des"
                        sh "./provisionw sag-apama-correlator"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
                stage('Designer and tools') {
                    agent { label 'docker' }
                    environment {
                        COMPOSE_PROJECT_NAME = 'sagdevops-templates'
                        CC_ENV = 'dev'
                    }
                    steps {
                        sh 'docker-compose pull cc'
                        sh 'docker-compose up -V -d cc'

                        sh "./provisionw sag-abe"                        
                        sh "./provisionw sag-designer-services"
                    }
                    post {
                        always {
                            sh 'docker-compose down'
                        }
                    }    
                }
            }
        }
    }
}
