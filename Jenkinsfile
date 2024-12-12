pipeline {
    agent any

    environment {
        registry = 'maizmazin/vproappdock'  // Docker registry name
        registryCredential = 'dockerhub'    // Docker service connection name
        GIT_REPO_URL = 'https://github.com/Maiz2k2/azure-cicd.git'  // Git repository URL
        GIT_BRANCH = 'main'                 // The branch to push to (adjust as needed)
        GIT_CREDENTIALS = 'GIT_CREDENTIALS' // Jenkins credentials for Git (ID you saved)
    }
    
    stages {
        // Stage 1: Build the project
        stage('BUILD') {
            steps {
                sh 'mvn clean install -DskipTests'  // Build the project, skipping tests
            }
            post {
                success {
                    echo 'Build successful, now archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'  // Archive the WAR file
                }
            }
        }

        // Stage 2: Run Unit Tests
        stage('UNIT TEST') {
            steps {
                sh 'mvn test'  // Run unit tests
            }
        }

        // Stage 3: Run Integration Tests
        stage('INTEGRATION TEST') {
            steps {
                sh 'mvn verify -DskipUnitTests'  // Run integration tests, skipping unit tests
            }
        }

        // Stage 4: Code Analysis with Checkstyle
        stage('CODE ANALYSIS WITH CHECKSTYLE') {
            steps {
                sh 'mvn checkstyle:checkstyle'  // Run Checkstyle analysis
            }
            post {
                success {
                    echo 'Checkstyle analysis completed successfully.'
                }
            }
        }

        // Stage 5: Push Artifact to Git Repository
        stage('Push Artifact to Git') {
            steps {
                script {
                    // Configure Git credentials
                    withCredentials([usernamePassword(credentialsId: GIT_CREDENTIALS, passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USER')]) {
                        // Clone the repository
                        sh '''
                        git config --global user.email "maiz.mazin@gmail.com"
                        git config --global user.name "Maiz2k2"
                        git clone https://${GIT_USER}:${GIT_PASSWORD}@${GIT_REPO_URL} repo
                        cd repo
                        '''
                        
                        // Copy the artifact to the cloned repository
                        sh '''
                        cp ../target/*.war ./  # Copy WAR file from the build output to the repository
                        git add .  # Stage the new file
                        git commit -m "Add new WAR artifact"  # Commit the artifact
                        git push origin ${GIT_BRANCH}  # Push the commit to the remote repository
                        '''
                    }
                }
            }
            post {
                success {
                    echo 'Artifact successfully pushed to Git repository.'
                }
                failure {
                    echo 'Failed to push artifact to Git repository.'
                }
            }
        }
    }
}
