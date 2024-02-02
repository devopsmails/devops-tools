end to end pipeline: 
  Github, Maven, Jenkins, SonarQube, Docker, EKS, ECR, Trivy, Terraform,AWS 
  Shared library

src:
 code:  https://github.com/devopsmails/mrdevops_java_app.git
SL: https://github.com/devopsmails/jenkins_shared_lib.git
MySL: https://github.com/devopsmails/suresh_shared_jenkins_library.git
Iscripts: https://github.com/devopsmails/installation_scripts.git

  
-------------
#!/bin/bash

sudo apt update -y

sudo apt upgrade -y 

sudo apt install openjdk-11-jre -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y 
sudo apt-get install jenkins -y
cat /var/lib/jenkins/secrets/initialAdminPassword

docker

sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y

sudo apt update -y

apt-cache policy docker-ce -y

sudo apt install docker-ce -y

#sudo systemctl status docker

sudo chmod 777 /var/run/docker.sock

sonar
---

docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube


cat /var/lib/jenkins/secrets/initialAdminPassword

docker container ls
-------------
Config Shared on Jenkins
----------
Dashboard >> Manage Jenkins >> System >> Global Pipeline Libraries:
Library:
name: java-shared-library(any)
def version: main(branchname)
project repo: https://github.com/devopsmails/suresh_shared_jenkins_library.git (Shred-lib-url) >> apply & save




========
need to do 
========

Private repo github:
jenkins agent:


======

importing shared lib on jenkins:
Jenkinsfile:
@Library('java-shared-library') _
--
gitCheckout.groovy
mvnTest.groovy
mvn need to be installed on ec2 server:
---------
maven
-----------
sudo apt update -y
sudo apt install maven -y
mvn -version
--------
Jenkins

password and username retrival:
connect to ec2 instance:

cd /val/lib/jenkins
ls
cd ./users
cat users.xml - show the list of users names & password in hashencryption: we can decrypt online
-----------
linux:
packages:
-------
sudo dpkg --list - shows the list of packages
sudo dpkg --list | grep jdk - shows the packages with name jdk
sudo apt-get purge openjdk-17-jre-headless:amd64 - purge(removes the mentioned package completely)
-----
sonarqube:
plugins for sonar:
  ------------
SonarQube Scanner
Sonar Gerrit
SonarQube Generic Coverage
Sonar Quality Gates
Quality Gates

      -------docker plugin
      docker
========
sonarqube home > administration >> security >> users >>: Token >> create or use existing token
sonarqube token name: admin
sonar token: squ_02a5373b78a03e686297b662381774764aef2f64

jenkins:
manage jenkins:
system >> sonar> check : environment var, add >> username: sonarqube-api, apply & save
system >> sonar> check : environment var, add >> username: sonar-api, 
auth-tokern: Add: jenkins,
username and secret text:
secret:paste the sonarqube auth token
userid, description: sonarqube-api >>
Choose: sonarqube-api>> apply & save
                -------------
Jenkinsfile: pipelin syntax: withsonarqubeplugin
qualitygate: pipeline syntax: waitforqualitygate plugin
------

SonarQualitystatus:
should config webhook to give result back to jenkins by:
sonarqube >> administrations >> configuration >> webhook: create: 
name: jenkins
URL: http://52.66.106.160:8080/sonarqube-webhook/
Must Enter

--------------
Trivy scanner for docker container vulnerbility:
install 
vi  trivy.sh
# A Simple and Comprehensive Vulnerability Scanner for Containers and other Artifacts, Suitable for CI.

sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

sh trivy.sh

-------
DOCKER PUSH
Pipeline syntax:
withcredentials: username & password separated
--------
Pipeline Script:
  jenkins reload
http://<your-jenkins-url>/reload
---------
Shared Library:
  
@Library('suresh_shared_jenkins_library') _
pipeline {
    
    agent any
    
    
    
    
    parameters {
        choice (name: "action", choices: "create\ndelete", description: "Choose to create or destory")
        string (name: "AWS_ACCOUNT_ID", description: "aws account id", defaultValue: "654347949882")
        string (name: "REGION", description: "ECR region", defaultValue: "ap-south-1")
        string (name: "ECR_REPO_NAME", description: "name of the docker build", defaultValue: "java_docker_ecr")
        string (name: "EKS_CLUSTER", description: "name of the EKS CLUSTER", defaultValue: "demo-cluster1")
        
        // string (name: "ImageName", description: "name of the docker build", defaultValue: "javaapp")
        // string (name: "ImageTag", description: "tag of the docker build", defaultValue: "v1")
        // string (name: "Dockerhubuser", description: "name of the Application", defaultValue: "sureshdevops1") 
    }
    
    //hardcoding the keys
    // environment {
    //     AWS_ACCESS_KEY_ID = "AKIAZQWRNK45EM5JLM7I"
    //     AWS_SECRET_ACCESS_KEY = "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"
    // }
    
    //cred type: USR & PSW
    environment {
        AWS_CREDS = credentials('aws_creds')
        AWS_ACCESS_KEY_ID = "$AWS_CREDS_USR"
        AWS_SECRET_ACCESS_KEY = "$AWS_CREDS_PSW"
    }
    
    //cred type: secret text
    
    // environment {
    //     AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
    //     AWS_SECRET_ACCESS_KEY_ID = credentials('AWS_SECRET_ACCESS_KEY')
    // }
    
    stages{
        stage('Git Checkout'){
        
            steps {
                gitCheckout (
                    branch: 'main',
                    url: "https://github.com/devopsmails/mrdevops_java_app.git/"
                )
            }
        }
        
        // stage('Maven Unit Test'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
        //             mvnTest()
        //         }
        //     }
        // }
        
        // stage('Maven Integrating Test'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
        //             mvnIntegrationTest()    
        //         }
        //     }
        // }
        
        // stage('Sonar: Static Code Analysis'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             def SonarQubeCredentialId = "jenkins_token"
        //             saticCodeAnalysis(SonarQubeCredentialId)
        //         }
        //     }
        // }
        
        // stage('Sonar: Quality Gate status Check'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             def SonarQubeCredentialId = "jenkins_token"
        //             QualityGateStatus(SonarQubeCredentialId)
        //         }
        //     }
        // }
        
        stage('Maven Build'){
        when {expression {params.action == "create"}}
            steps {
                script{
                    
                    mvnBuild()
                }
            }
        }
        
        // stage('Docker image Build'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerBuild("${params.ImageName}","${params.ImageTag}","${params.Dockerhubuser}")
        //         }
        //     }
        // }
        
        // stage('Docker image Scan: Trivy'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.Dockerhubuser}")
        //         }
        //     }
        // }
        
        // stage('Docker image Push: Dockerhub'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.Dockerhubuser}")
        //         }
        //     }
        // }
        
        // stage('Docker image Claen up'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerImageCleanup("${params.ImageName}","${params.ImageTag}","${params.Dockerhubuser}")
        //         }
        //     }
        // }
        
        // stage('Docker image Build: ECR'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerBuildECR("${params.AWS_ACCOUNT_ID}","${params.REGION}","${params.ECR_REPO_NAME}")
        //         }
        //     }
        // }
        
        // stage('Docker image Scan: Trivy : ECR'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerImageScanECR("${params.AWS_ACCOUNT_ID}","${params.REGION}","${params.ECR_REPO_NAME}")
        //         }
        //     }
        // }
        
        // stage('Docker image Push: ECR'){
        // when {expression {params.action == "create"}}
        //     steps {
                
        //         script{
                    
        //             dockerImagePushECR("${params.AWS_ACCOUNT_ID}","${params.REGION}","${params.ECR_REPO_NAME}")
        //         }
        //     }
        // }
        
        // stage('Docker image Claen up'){
        // when {expression {params.action == "create"}}
        //     steps {
        //         script{
                    
        //             dockerImageCleanupECR("${params.AWS_ACCOUNT_ID}","${params.REGION}","${params.ECR_REPO_NAME}")
        //         }
        //     }
        // }
        
        stage ('EKS Creating: Terraform') {
            
            steps {
                script {
                    dir('eks_module') {
                        sh """
                        terraform init
                        terraform  plan -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' -var 'region=${params.REGION}' --var-file=./config/terraform.tfvars                     
                        terraform apply -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' -var 'region=${params.REGION}' --var-file=./config/terraform.tfvars --auto-approve
                        """
                    }
                }
            }
        }
        
        stage ('Connecting to EKS') {
            
            steps {
                script {
                    
                    """
                    aws configure set aws_access_key_id  $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key  $AWS_SECRET_ACCESS_KEY
                    aws configure set region ${params.REGION}
                    aws eks --region ${params.REGION} update-kubeconfig --name ${params.EKS_CLUSTER}
                    """
                }
            }
        }
        
        stage ('Deploying to EKS Cluster') {
            steps {
                script {
                    def apply=false
                    
                    try {
                        input message: 'Please confirm to deploy on EKS', ok: 'Deploy'
                        apply = true
                    }catch(err){
                        apply= false
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        sh"""
                          kubectl apply -f . #pblm#
                        """
                    }
                }
            }
        }
    }
}
