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
    
    stage('nexus upload'){
        steps{
            script{
                nexusArtifactUploader artifacts: 
                [
                    [artifactId: '01-maven-web-app', 
                    classifier: '', 
                    file: 'target/01-maven-web-app.war', 
                    type: 'war']
                    ],
                 credentialsId: 'nexus-credentials',
                  groupId: 'in.ashokit', 
                  nexusUrl: '43.207.145.9:8081/', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: 'mysnapshotrepo',
                   version: '1.0-SNAPSHOT'
            }
        }
    }
    
    
    }

}