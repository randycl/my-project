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
                    docker.image('my-gradle-app').run('-p 8080:8080')
                }
            }
        }
    }
    post {
        failure {
            echo 'Build or tests failed!'
        }
    }
}
