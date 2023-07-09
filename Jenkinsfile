pipeline {
    agent {
        label 'build'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            environment {
                // Set environment variables for the build
            }
            steps {
                // Build the application
                sh "mvn clean package -Dmaven.test.skip=true"
            }
        }

        stage('Deploy to Staging') {
            environment {
                // Set environment variables for the deployment
            }
            steps {
                // Deploy to the staging environment
                sh "kubectl apply -f k8s/staging/"
            }
        }

        stage('Integration Tests') {
            environment {
                // Set environment variables for the tests
            }
            steps {
                // Run integration tests against the staging environment
                sh "mvn verify -Pintegration-tests"
            }
        }

        stage('Deploy to Production') {
            environment {
                // Set environment variables for the deployment
            }
            steps {
                // Deploy to the production environment
                sh "kubectl apply -f k8s/production/"
            }
        }
    }

    post {
        always {
            // Clean up after the pipeline finishes
        }
        success {
            slackSend channel: '#builds',
                color: 'good',
                message: "Build <${BUILD_URL}|#${BUILD_NUMBER}> succeeded."
        }
        failure {
            slackSend channel: '#builds',
                color: 'danger',
                message: "Build <${BUILD_URL}|#${BUILD_NUMBER}> failed."
        }
    }
}