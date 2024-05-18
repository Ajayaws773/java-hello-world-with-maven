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
          sh 'mvn clean package'
    
       }
     }
     stage('sonar') {
       steps {
          sh 'mvn sonar:sonar \
  -Dsonar.projectKey=cintapproject \
  -Dsonar.host.url=http://$sonar:9000 \
  -Dsonar.login=b91f9dfb81ad7dcebf2367312a29311659e680b4'
    
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
              sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/endtoend/target/*.war ec2-user@$tomcat:/usr/local/tomcat/webapps/' 
        }
    
       }
     }

     }
	 post {
      always {
       emailext (
          subject: "pipeline status: ${BUILD_NUMBER}",
          body:'''<html>
          <body>
           <p>Build Status: ${BUILD_STATUS}</p>
           <p>Build Number: ${BUILD_NUMBER}</p>
           <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
          </body>
          </html>''',
          to: 'ajayawsdevops773@gmail.com',
          from: 'ajayawsdevops773@gmail.com',
          replyTo: 'ajay.p@cintap.com',
          mimeType: 'text/html'
)
}
}
}
