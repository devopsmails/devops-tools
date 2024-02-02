```
pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/Aj7Ay/Netflix-clone.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    // To generate the below command go to sonar dash board >> projects >> manually >> Enter the project name: Netflix, branch: main >> create
                    // sonar dash board >> projects >> locally >> use existing token: squ_584ce430eec35d9e8195b3e230ea72fd5f607aa8 >> generate
                    // copy paste the code
  
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=netflix \
                    -Dsonar.projectKey=netflix '''
                }
            }
        }
        stage("quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token' 
                }
            } 
        }
        
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        
        stage('OWASP FS SCAN') {
        steps {
            dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
            dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }    
        }
    
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker-hub', toolName: 'docker'){   
                       sh "docker build --build-arg TMDB_V3_API_KEY=ff7b18fd132db08968c63c42be8fc12f -t netflix ."
                       sh "docker tag netflix sureshdevops1/netflix:latest "
                       sh "docker push sureshdevops1/netflix:latest "
                    }
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image sureshdevops1/netflix:latest > trivyimage.txt" 
            }
        }
        stage('Deploying to container'){
            steps {
                sh "docker run -d --name netflix4 -p 8081:80 sureshdevops1/netflix:latest"
            }
        }
        stage ('Deploying to K8s'){
            steps {
                script{
                    dir('Kubernetes') {
                        withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                            sh "kubectl apply -f deployment.yml"
                            sh "kubectl apply -f service.yml"
                        }
                    }
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
        attachmentsPattern: '**/trivyfs.txt, **/trivyimage.txt'
    }
  }
}
```

<img width="779" alt="image" src="https://github.com/devopsmails/devops/assets/119680288/aaae029a-fe69-4d5d-b10f-b196c8ebb0e5">
