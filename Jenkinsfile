
// export JENKINS_URL=http://ccbvtauto.eur.ad.sag:8080
// curl -X POST -F "jenkinsfile=<Jenkinsfile" $JENKINS_URL/pipeline-model-converter/validate

def testTemplates(templates) {
    for (t in templates) {
        sh "docker-compose run --name $t --rm -e CC_TEMPLATE=$t test"
        junit "build/tests/**/*.xml"
        archive "build/templates/${t}.zip"
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
                        testTemplates(['sag-creds', 'sag-repos'])
                    }
                }
                stage('Jenkins') {
                    steps {
                        testTemplates(['jenkins'])
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
