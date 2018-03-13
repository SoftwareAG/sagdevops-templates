
def testTemplates(templates) {
    def builders = [:]
    for (x in templates) {
        def template = x // Need to bind the label variable before the closure - can't do 'for (label in labels)'
        builders[template] = {
            sh "docker-compose run --rm -e TEMPLATE=$template test"
        }                        
    }
    parallel builders // kick off parallel provisioning    
}

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
                stash 'scripts'
                sh 'docker-compose pull'
                sh 'docker-compose up -d cc'
                sh 'docker-compose logs cc'
                // sleep(60)
                // sh 'docker-compose exec cc antcc waitContainerInit'                
                sh 'docker-compose run --rm init1'
                sh 'docker-compose logs'
            }
        }
        stage("Test") {
            steps {
                sh "docker-compose run --rm -e TEMPLATE=jenkins test"    
                // testTemplates(['jenkins'])
            }
            post {
                always {
                    sh 'docker-compose logs'
                    sh 'docker-compose down'
                }
            }
        }
    }
}
