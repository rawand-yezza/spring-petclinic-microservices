pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/rawand-yezza/spring-petclinic-microservices.git'
      }
    }
    stage('Verify tooling') {
       steps {
        sh '''
          docker version
          docker info
          docker compose version
          curl --version
        '''  
       }
    }
   
    stage('check version') {
      steps {
        sh 'aws --version'
        echo 'test'
      }
    }
    stage('Deploy to AWS') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'jenkins-demo'
        ]]) {
          sh './run_cloudformation.sh'
        }
      }
    }
  }
  post {
    always {
      sh 'docker-compose down --remove orphans -v'
      sh 'docker-compose ps'
    }
    
  }
}

