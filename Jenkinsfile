pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build and Test') {
            steps {
                script {
                    docker.build('my-gradle-app')
                }
            }
        }
        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'app/build/libs/*.jar', allowEmptyArchive: true
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-gradle-app')
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    docker.image('my-gradle-app').run('-d -p 8380:8080 --name my-project')

                    // Print the Docker logs to the Jenkins console
                    sh 'docker logs my-project'
                }
            }
        }
    }
    post {
        always {
            script {
                // Cleanup: Remove the container if it exists
                sh '''
                if [ $(docker ps -a -q -f name=my-project) ]; then
                    docker rm -f my-project
                fi
                '''
            }
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
