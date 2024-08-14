pipeline {
  environment {
    dockerimagename = "awertoss/myapp"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/awertoss/myapp.git'
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-awertoss'
           }
      steps{
        script {
          docker.withRegistry( 'https://index.docker.io/v1/', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }
  }
}
