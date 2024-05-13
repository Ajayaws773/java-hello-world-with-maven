pipeline {
	agent any
	stages {
	stage('code') {
       steps {
          git changelog: false, poll: false, url: 'https://github.com/Ajayaws773/java-hello-world-with-maven.git'
    
       }
     }
     stage('build') {
       steps {
          sh 'mvn package'
    
       }
     }
     stage('sonar') {
       steps {
          sh 'mvn sonar:sonar \
  -Dsonar.projectKey=cintap \
  -Dsonar.host.url=http://100.27.11.219:9000 \
  -Dsonar.login=ddd09a7d8d2005118d19245798e3633cf179763c'
    
       }
     }
     stage('artifact') {
       steps {
          sh 'chmod 777 artifact.sh'
          sh './artifact.sh'
    
       }
     }
     stage('deploy') {
       steps {
          sshagent(['ec2-user']) {
              sh 'pwd'
              sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/gitpipeline/target/*.jar ec2-user@172.31.52.47:/usr/local/tomcat/webapps/' 
        }
    
       }
     }

     }
}
