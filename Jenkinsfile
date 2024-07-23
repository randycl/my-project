pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git branch: 'main', url: 'https://github.com/randycl/my-project.git'
            }
        }
        
        stage('Build and Test') {
            steps {
                // Build and test the project using Docker
                script {
                    docker.build('my-gradle-app').inside {
                        sh './gradlew build'
                        sh './gradlew test'
                    }
                }
            }
        }
        
        stage('Archive Results') {
            steps {
                // Archive the test results
                junit '**/build/test-results/test/*.xml'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build('my-gradle-app', '.')
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    docker.image('my-gradle-app').run('-p 8080:8080')
                }
            }
        }
    }

    post {
        success {
            echo 'Build and tests succeeded!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
