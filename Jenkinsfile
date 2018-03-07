pipeline {
    agent {
        label 'docker'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
        disableConcurrentBuilds()
    }
    environment {
        COMPOSE_PROJECT_NAME = 'sagdevopstemplates'
        COMPOSE_FILE = 'dev.yml'
        SAG_AQUARIUS = 'aquarius-bg.eur.ad.sag'
    }
    stages {
        stage('Init') {
            steps {
                sh 'docker-compose run --rm init1'
                sh 'docker-compose logs'
            }
        }
        stage("Test") {
            environment {
                TEMPLATE = 'jenkins'
            }
            steps {
                sh "docker-compose run --rm test"
            }
            post {
                always {
                    sh 'docker-compose down'
                }
            }
        }
    }
}
