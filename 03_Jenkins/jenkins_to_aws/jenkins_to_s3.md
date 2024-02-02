This files helps integrate & share files from jenkins to s3 bucket
pre-requisites
```
Should have access key & secret access key
manage jenkins >> plugins:**AWS Credentials Plugin** >> installed
manage jenkins >> creadentials: id: aws-creds, access_key=AKIAQVZMQXIS6PQOO37C, secret_access_key=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
```
Copy files & logs from jenkins to s3:
------------
```
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

complete pipeline: https://github.com/devopsmails/devops/blob/main/projects/Mr.CloudBook/Netflix-Clone-CICD/complete_pipeline.md
```

