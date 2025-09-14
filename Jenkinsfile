pipeline {
  agent any
  environment {
    REPO = "devops-task"
    IMAGE_TAG = "${env.GIT_COMMIT}"
    DOCKER_USER = "harshit126"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Install & Test') {
      steps {
        sh 'npm ci'
        sh 'npm test || true'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${DOCKER_USER}/${REPO}:${IMAGE_TAG} ."
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh 'echo $DH_PASS | docker login -u $DH_USER --password-stdin'
          sh "docker push ${DOCKER_USER}/${REPO}:${IMAGE_TAG}"
        }
      }
    }

    // Optional: add AWS/GCP deploy stages when ready (see templates)
  }
  post {
    always {
      sh "docker image rm ${DOCKER_USER}/${REPO}:${IMAGE_TAG} || true"
    }
    success { echo "SUCCESS" }
    failure { echo "FAILURE" }
  }
}
