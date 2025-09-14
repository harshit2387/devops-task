pipeline {
  agent any
  environment {
    REPO = "devops-task"
    IMAGE_TAG = "${env.GIT_COMMIT}"
    DOCKER_USER = "YOUR_DOCKERHUB_USERNAME"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Install & Test') {
      steps {
        sh 'npm ci'
        sh 'npm test'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker build -t $DOCKER_USER/$REPO:$IMAGE_TAG ."
      }
    }
    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh "docker push $DOCKER_USER/$REPO:$IMAGE_TAG"
        }
      }
    }
  }
}
