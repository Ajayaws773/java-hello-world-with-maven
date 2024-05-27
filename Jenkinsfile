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
  -Dsonar.projectKey=$projectname \
  -Dsonar.host.url=http://$sonar:9000 \
  -Dsonar.login=b91f9dfb81ad7dcebf2367312a29311659e680b4'
    
       }
     }
     stage('artifact') {
       steps {
          sh 'chmod 777 jenkins/artifact.sh'
          sh './jenkins/artifact.sh'
    
       }
     }
     stage('deploy') {
       steps {
         
	sh '''
        echo $WORKSPACE
	echo $tomcatip
           chmod 777 jenkins/deploy.sh
	   ./jenkins/deploy.sh
	'''
}
       }
     

     }
	 post {
      always {
       emailext (
          subject: "pipeline status: ${BUILD_NUMBER}",
          body:'''<html>
          <body>
	  <p>User: ${BUILD_USER}</p>
           <p>Build Status: ${BUILD_STATUS}</p>
           <p>Build Number: ${BUILD_NUMBER}</p>
	   <p>Environment: ${Environment}</p>
           <p>ServiceToDeploy: ${ServiceToDeploy}</p>
	   <p>Repository: ${projectname}</p>
           <p>Pipeline name: ${PROJECT_NAME}</p>
           <p>Job description: ${JOB_DESCRIPTION}</p>
           <p>Check the <a href="${BUILD_URL}">console output</a>.</p>
          </body>
          </html>''',
          to: 'ajay.p@cintap.com',
          from: 'ajayawsdevops773@gmail.com',
          replyTo: 'devops@cintap.com',
          mimeType: 'text/html'
)
}
}
}
