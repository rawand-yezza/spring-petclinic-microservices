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
     /* stage('Deploy to AWS') {
      steps {
        sh 'test deploy'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'petclinic'
        ]]) {
          sh 'eksctl create cluster --name petclinic --version 1.24 --region eu-west-3 --nodegroup-name standard-workers --node-type t3.micro --nodes 4 --nodes-min 2 --nodes-max 6 --managed'
          sh 'test eks '        
        } 
      }
    }   */ 
      stage ('Check the cluster'){
      steps  {
        
          withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',

          credentialsId: 'petclinic'
        ]]){
        
        sh 'aws eks update-kubeconfig --name petclinic --region eu-west-3'
       // sh 'eksctl get cluster'
        sh 'export AWS_DEFAULT_REGION=eu-west-3' 
        }


      }
    } 
/*      stage ('Enable to connect to the cluster'){
      steps  {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'petclinic'
        ]]){
        sh 'aws eks update-kubeconfig --name petclinic --region eu-west-3'
      }}
    } */
   /*  stage ('Deploy resources in k8s'){
      steps  {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
          credentialsId: 'petclinic'
        ]]){
        sh 'chmod 777 run_kubernetes.sh'
        sh './Kubernetes/run_kubernetes.sh'
        }
      }
    }  */
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