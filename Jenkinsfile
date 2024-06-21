pipeline {
    agent { label 'builtin' }
    environment {
        DEPLOY_WEBHOOK_URL = "http://amarillo.mfdz.de:8888/${env.BRANCH_NAME}" 
        DEPLOY_SECRET = credentials('AMARILLO-JENKINS-DEPLOY-SECRET')
    }
    stages {
        stage('Notify CD script') {
            steps {
                echo 'Triggering deploy webhook'
                script {
                    def response = httpRequest contentType: 'APPLICATION_JSON',
                        httpMode: 'POST', requestBody: '{}', authentication: 'AMARILLO-JENKINS-DEPLOY-SECRET',
                        url: "${DEPLOY_WEBHOOK_URL}"
                }
            }
        }
    }
}