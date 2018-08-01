// curl -X POST -F "jenkinsfile=<Jenkinsfile.builder" http://ccbvtauto.eur.ad.sag:8080/pipeline-model-converter/validate

def buildAndTest(release) {
    sh """
    export COMPOSE_PROJECT_NAME="builder-$release"

    docker-compose config
    docker-compose build --pull --force-rm --no-cache cc
    
    cd templates/sag-spm-config
    docker-compose config
    docker-compose build --force-rm --no-cache
    cd ../..
    
    docker-compose push cc
    """
}

pipeline {
    agent {
        label 'docker'
    }
    parameters {
        //choice(choices: '10.3\n10.2\n10.1', description: 'Test templates for this release', name: 'RELEASE')
        string(defaultValue: '10.3.0.0.38', description: 'commandcentral-server image TAG to use', name: 'CC_TAG')
    }    
    environment {
        // version of the Command Central docker images build/release
        CC_TAG = "${params.CC_TAG}"

        // images are from private registry
        CC_SERVER_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-server'
        CC_CLIENT_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-client'
        CC_BUILDER_IMAGE = 'daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-builder'

        REPO_FIX = 'GA_Fix_Repo'
        REPO_HOST = 'aquarius-bg.eur.ad.sag'
        FIXES = 'ALL'

        // Licenses archive URL to load
        // LICENSES_URL = "http://irepo.eur.ad.sag/projects/DEVOPS/repos/command-central/raw/licenses/sag10-rnd-lnx-licenses.zip?at=refs%2Fheads%2Fmaster"
    }
    stages {
        stage('Build') {
            parallel {
                stage('10.3') {
                    environment {
                        TAG = '10.3'
                        REPO_PRODUCT = 'SuiteTest'
                        REPO_FIX = 'GA_Fix_Repo'
                        FIXES = '[]'
                        CC_NODE_IMAGE = "daerepository03.eur.ad.sag:4443/ccdevops/commandcentral-node:$CC_TAG"
                    }
                    steps {
                        buildAndTest('10.3')
                    }
                }
                stage('10.2') {
                    environment {
                        TAG = '10.2'
                        REPO_PRODUCT = '102apr2018_SIC'
                        CC_NODE_IMAGE = 'daerepository03.eur.ad.sag:4443/softwareag/commandcentral:10.2.0.1.9-node'
                    }
                    steps {
                        buildAndTest('10.2')
                    }
                }
                stage('10.1') {
                    environment {
                        TAG = '10.1'
                        REPO_PRODUCT = '101oct2017_SIC'
                        CC_NODE_IMAGE = 'daerepository03.eur.ad.sag:4443/softwareag/commandcentral:10.1.0.8.141-node'
                    }
                    steps {
                        buildAndTest('10.1')
                    }
                }                                                
            }            
        }
    }
}
