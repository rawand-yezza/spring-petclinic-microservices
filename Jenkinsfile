pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/dsirine/spring-petclinic-microservices.git'
      }
    }
    stage('Verify tooling') {
       steps {
        sh '''
          docker version
          docker info
          docker compose version
          curl --version
          jq --version
        '''
       }
    }
    stage ('Prune docker data'){
      steps  {
        sh 'docker system prune -a --volumes -f'
      }
    }
    stage('Start containers') {
      steps {
        sh 'docker-compose up -d'
        sh 'docker-compose ps'
      }
    }
    stage('Run tests again the container') {
      steps {
        sh 'curl http://localhost:8888/'
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
