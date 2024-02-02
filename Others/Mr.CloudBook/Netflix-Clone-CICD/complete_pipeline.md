```
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh "touch filee.txt, file2.txt"
      }
    }

    stage('StageTwo') {
      steps {
        sh "echo 'stage one is created' >> filee.txt"
        sh "echo 'stage one is created' >> file2.txt"
      }
    }

    stage('Copy file to S3 bucket') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            aws s3 cp /var/lib/jenkins/workspace/${JOB_NAME}/file2.txt s3://sur-aws1/dev/file2.txt
            aws s3 cp /var/lib/jenkins/jobs/netflix1/builds/${BUILD_NUMBER}/log s3://sur-aws1/dev/logs/${JOB_NAME}_log.txt
            // But we can't read the current log format need to work on it
          '''
        }
      }
    }
  }

  post {
    always {
      emailext attachLog: true,
        to: 'devopsmails1@gmail.com',
        subject: """Job: ${env.JOB_NAME} ${currentBuild.result}""",
        body: """Project: ${env.JOB_NAME} <br>
        Build Number: ${env.BUILD_NUMBER} <br>
        URL: ${env.BUILD_URL}""",
        attachmentsPattern: '**/filee.txt, **/file2.txt'
    }
  }
}
```
