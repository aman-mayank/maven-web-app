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

                def readPomVersion = readMavenPom file: 'pom.xml'
                def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "mysnapshotrepo" : "myreleaserepo"
                nexusArtifactUploader artifacts: 
                [
                    [artifactId: '01-maven-web-app', 
                    classifier: '', 
                    file: 'target/01-maven-web-app.war', 
                    type: 'war']
                    ],
                 credentialsId: 'nexus-credentials',
                  groupId: 'in.ashokit', 
                  nexusUrl: '3.112.69.61:8081/', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: nexusRepo,
                   version: "${readPomVersion.version}"
            }
        }
    }
    
    stage('create image'){
        steps{
            sh "docker build -t amanmayank97/01-maven-web-app ."
        }
    }

    stage('push image'){
        steps{
        withCredentials([string(credentialsId: 'dockerpsw', variable: 'dockerpwd')]) {
           sh "docker login -u amanmayank97 -p ${dockerpwd}"
           sh "docker push amanmayank97/01-maven-web-app"
         }
        }
    }
  }

}