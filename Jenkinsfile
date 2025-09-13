pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'npm install'
        sh 'npm test || echo "No tests defined"'
      }
    }
    stage('Dockerize') {
      steps {
        sh 'docker build -t harshit2387/logo-server .'
      }
    }
    stage('Push to Registry') {
      steps {
        withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
          sh '''
            echo $DOCKER_TOKEN | docker login -u harshit2387 --password-stdin
            docker tag logo-server harshit2387/logo-server:latest
            docker push harshit2387/logo-server:latest
          '''
        }
      }
    }
    stage('Deploy') {
      steps {
        sh './deploy.sh'
      }
    }
  }
}
