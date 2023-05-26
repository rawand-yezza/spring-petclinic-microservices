pipeline {
  agent any
   stages {
   /* stage('Cloning Git') {
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
          aws --version
          eksctl version
          kubectl version --client --output=yaml
        '''  
       }
    }
    stage ('Prune docker data'){
      steps  {
        sh 'docker system prune -a --volumes -f'
      }
    }
      stage('Deploy to AWS') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'petclinic'
        ]]) {
          sh 'eksctl create cluster --name petclinic --version 1.24 --region eu-west-3 --nodegroup-name standard-workers --node-type t3.micro --nodes 4 --nodes-min 4 --nodes-max 6'
        }
      }
    } */
    stage ('Check the cluster'){
      steps  {
         withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'petclinic'
        ]])
        sh 'eksctl get cluster'
      }
    }
    stage ('Enable to connect to the cluster'){
      steps  {
        sh 'aws eks update-kubeconfig --name petclinic --region eu-west-3'
      }
    }
    stage ('Deploy resources in k8s'){
      steps  {
        sh './run_kubernetes.sh'
      }
    }
    stage ('curl'){
      steps  {
        sh 'curl http://localhost:8761'
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