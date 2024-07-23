pipeline {
    agent any

    tools {
        // Install the JDK and Gradle on the agent
        jdk 'JDK 11'
        gradle 'Gradle 6.8'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git 'https://github.com/randycl/my-project.git'
            }
        }
        
        stage('Build') {
            steps {
                // Run the Gradle build task
                sh './gradlew build'
            }
        }
        
        stage('Test') {
            steps {
                // Run the Gradle test task
                sh './gradlew test'
            }
        }
        
        stage('Archive Results') {
            steps {
                // Archive the test results
                junit '**/build/test-results/test/*.xml'
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

