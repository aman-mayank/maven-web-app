pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                git branch: 'test', url: 'https://github.com/aman-mayank/maven-web-app.git'
            }
        }
    
    stage('maven build') {
            steps {
                sh 'mvn clean package'
            }
        }
    
    stage('SonarQube analysis') {   
        steps{  
            script{  
        withSonarQubeEnv('sonarserver') {
       	sh "mvn sonar:sonar"
        }
      }
        }
    }
}
}