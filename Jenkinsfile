pipeline {
  environment {
    dockerimagename = "chinchanchontom/acc-info:latest"
    dockerImage = ""

  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/chinchanchonTom/diplom.git'
      }
    }
    stage('Checkout tag') {
      steps{
        script {
          sh 'git fetch'
          gitTag=sh(returnStdout:  true, script: "git tag --sort=-creatordate | head -n 1").trim()
          echo "gitTag output: ${gitTag}"
        }
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image:tags') {
      environment {
               registryCredential = 'f94ed121-bdac-4ee0-8b34-87210237c8b3'
           }
      steps{
        script {
          docker.withRegistry( 'https://index.docker.io/v1/', registryCredential ) {
            dockerImage.push("${gitTag}")
          }
        }
      }
    }
    stage('sed env') {
      environment {
              envTag = ("${gitTag}")
           }    
      steps{
        script {
          sh "sed -i \'18,22 s/gitTag/\'$envTag\'/g\' myapp-deploy.yml"
          sh 'cat myapp-deploy.yml'
        }
      }
    }
    stage('Deploying myapp-deploy to Kubernetes') {
      steps {
        script {
          kubernetesDeploy (configs:'myapp-deploy.yml', kubeconfigId:'k8s-credentials' )
        }
      }
    }
  }    
}  
