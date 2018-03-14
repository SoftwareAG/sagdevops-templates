
def testTemplates(templates) {
    def builders = [:]
    for (x in templates) {
        def template = x // Need to bind the label variable before the closure - can't do 'for (label in labels)'
        builders[template] = {
            sh "docker-compose run --rm -e CC_TEMPLATE=$template test"
            // junit "build/tests/$CC_ENV/"
            // archive "templates/${template}/build/.zip"
        }                        
    }
    parallel builders // kick off parallel provisioning    
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
        EMPOWER = credentials('EMPOWER')
    }
    stages {
        stage('Init') {
            steps {
                stash 'scripts'
                sh 'docker-compose pull'
                // sh 'docker-compose up -d cc'
                // sleep(60)
                // sh 'docker-compose exec cc antcc waitContainerInit'                
                sh 'docker-compose run --rm initcc'
            }
        }
        stage("Test") {
            steps {
                // sh "docker-compose run --rm -e CC_TEMPLATE=jenkins test"    
                testTemplates(['jenkins', 'sag-creds', 'sag-repos'])
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
    }
}
