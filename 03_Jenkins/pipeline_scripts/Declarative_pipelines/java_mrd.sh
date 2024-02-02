YT: https://youtu.be/8KZi7KBpk0I

aws:
=====
EC2:
Jenkins;
--------
name: Jenkins
AMI: Ubuntu-20.04 LTS
Instance type: t2.medium
Keypair: Key1
sg: inbound: alltrafic anywhereipv4
storage: 20
Launch instance
-----------
Sonarqube:
---------
name: SonarQube
AMI: Ubuntu-20.04 LTS
Instance type: t2.medium
Keypair: Key1
sg:  inbound: alltrafic anywhereipv4
storage: 20
Launch instance
----------------
Nexus:
-------
name: Nexus
AMI: Ubuntu-20.04 LTS
Instance type: t2.medium
Keypair: Key1
sg: inbound:8081-8083
storage: 20
Launch instance
---------------
Kubernetes(2 servers):
--------
name: K8
AMI: Ubuntu-20.04 LTS
Instance type: t3.medium
Keypair: Key1
sg: inbound: alltrafic
storage: 20
Number of instances: 2
Launch instance
----------------
On Jenkins server:
___
java & jenkins installations:
---------
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
sudo service jenkins start
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
      -------
 Docker: (To Use Docker commands on Jenkins should install Docker on Jenkins Machines)

 
============
on Sonar Server
SonarQube installations:
------------
sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y

sudo apt upgrade -y

sudo apt update -y

apt-cache policy docker-ce -y

sudo apt install docker-ce -y

sudo chmod 777 /var/run/docker.sock

sudo systemctl status docker
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
---------------
nexus installations:
sudo su
ex: 
root@ip-172-31-88-139:/home/ubuntu#
 
apt-get update -y

echo "Install Java"
apt-get install openjdk-8-jdk -y
java -version

echo "Install Nexus"
useradd -M -d /opt/nexus -s /bin/bash -r nexus
echo "nexus ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nexus

mkdir /opt/nexus
wget https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz

tar xzf nexus-3.29.2-02-unix.tar.gz -C /opt/nexus --strip-components=1
chown -R nexus:nexus /opt/nexus

vi /opt/nexus/bin/nexus.vmoptions
#in The file 
# ../sonatype-
# need to change to 
# ./sonatype- in 4 places; wq!
------------
 vi  /opt/nexus/bin/nexus.rc

#run_as_user=""
to 
run_as_user="nexus"
:wq!

start nexus

sudo -u nexus /opt/nexus/bin/nexus start

-----------
Jenkins web access:
jenkins ec2:public ip: 8080

install suggested plugins
Username: Suresh_Jenkins
PWD: Jenkins
Full name: Suresh
E-mail address: Devopsmails1@gmail.com

----------
sonarwebaccess:
sonar ec2:public ip: 9000
username: admin
pwd: admin
changed: Admin
------------
nexus webaccess:
nexus ec2:pubip:8081

username: admin
pwd:
on nexus server: 
cat /opt/nexus/sonatype-work/nexus3/admin.password
copy paste the pwd:
newpwd: nexus

check:Enable anonymous access
----------

K8 installations:
---------

On Master & node:
----------

Step1:
On Master & worker node
sudo su
apt-get update  
apt-get install docker.io -y
service docker restart  
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -  
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >/etc/apt/sources.list.d/kubernetes.list
apt-get update
apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y  

Step2:
On Master:
   kubeadm init --pod-network-cidr=192.168.0.0/16
need to enable  Security Group: 6433 port or All trafic
   >Copy the token and paste it into the worker node.


Step3:
On Master: 
  exit
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config


step4:
On Master:
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml


Our Kubernetes installation and configuration are complete
============
Integrating sonarqube with jenkins
=========
Manage Jenkins >> manage plugins >> Available plugins >>
SonarQube ScannerVersion
Sonar Quality Gates
Quality Gates
Sonar Gerrit
SonarQube Generic Coverage
install without restart.
----------
Sonar Quality report:

on sonarqube Dashboard:
==========
type1:
administartions:
security>

Type2:
----
sonar dashboard:

Top right corner user icon>>
security >>
(The below is same for both the types)
users> token list icon> 
Generate Tokens
Name: 
jenkins
expires in : never, Generate
token: 
squ_87fcc376a6841b43410fdf02b7d3d2c863b7fab0
-------
Manage jenkins >> system >> ctrl + F:  SonarQube servers
check: Environment variables
SonarQube installations:
Name: sonar-server
Server URL: http://18.206.125.200:9000
Server authentication token:
sonar-token
 -----

sonar Quality  gate status to Jenkins
==========
on sonarqube Dashboard:

Adminisration >> Cinfigurations >> Webhooks >> 
name: jenkins
URL: (Jenkins url to send to report)
http://54.197.73.238:8080/sonaqube-webhook/
create
----------------

Jenkins Dash board:
New item >>
name: Mr. Devops_java_ci
type: Pipeline
create:
--------
Pipeline:
====
stage: Git Checkout
Definition:
Pipeline Script from SCM

SCM:
Git

Repositories:
https://github.com/devopsmails/mrdevops_nexus_helm_cicd_app.git

Branches to build:
Branch Specifier:
*/main

Script Path:(if Jenkins file is created somewhere ned to mention that path /../../Jenkinsfile)
Jenkinsfile
      apply & save
      ------------
Pipeline syntax:
Steps:
Sample Step:
select: 
WithSonarQubeEnv: ...

Server authentication token:
Select: 
sonar-token
Generate Pipeline Script & copy syntax to jenkinsfile
(ex:
withSonarQubeEnv(credentialsId: 'sonar-token') {
    // some block
})
----------
As using Agent Docker
========
Need to install plugins:
---------
Docker
Dcoker pipeline
and need to install docker on Jenkins machine:
--------------------
stage:Sonar Quality Check
==
Need to install maven on jenkins
sudo apt-get update & install maven -y

------------
Stage: Sonar Quality Gate status

sonar webhook should be set up with jenkins IP to send the status

jenkins pipeline syntax:

waitforqualitygatestatus
-----------
nexus gui:
----
nexus server IP & 8081

Integration Nexus with Jenkins:
==============
Nexus Dashboard:
Settings symbol>>repositories>>click: Create repositories:
in seen list :
Click: docker (hosted)>>
Name: (meaningful:) docker-hosted
check: HTTP>>port 8083
click: Create repository
             -------
Click: Browse
click: Created repo name to view artifats in the file!

 ============
On Jenkins Server:
==========
sudo su
cd /var/lib/jenkins/workspace/Mr.devops_java_ci
github:
https://github.com/vikash-kumar01/CICD_Java_gradle_application/wiki
CLICK:
Creating Docker hosted repository in Nexus and pushing the docker image through Jenkins>>
At page end:
>> vi /etc/docker/daemon.json
{ "insecure-registries":["nexus_machine_ip:8083"] }
replace nexus_machine_ip with nexus ip address
{ "insecure-registries":["34.238.232.93:8083"] }
:wq!

systemctl restart docker
docker info:
if the above 34.238.232.93:8083 is configured >>
Need to docker login to nexus repo to push arti:
>>
docker login -u admin -p nexus 34.238.232.93:8083
result:
Login Succeeded
-----
Jenkins dashboard:
--------------
pipeline syntax:
---------
withcredentials:(to variable Nexus_password)
secrettext:******(nexus)
userid:nexus_cred_pwd
withCredentials([string(credentialsId: 'nexus_cred_pwd', variable: 'nexus_pwd')])

Creating Environment Variable: for versioning
-----
pipeline{

    agent any
    environment{

        VERSION="${env.BUILD_ID}"

    }

current stage:
--------
stage ('Docker image build & docker push Nexus repo'){

            steps{
                
                script{
                    withCredentials([string(credentialsId: 'nexus_cred_pwd', variable: 'nexus_pwd')]) {
                        sh '''
                            docker build -t 34.238.232.93:8083/springapp:${VERSION} . 

                            docker login -u admin -p  $nexus_pwd 34.238.232.93:8083
                            docker push 34.238.232.93:8083/springapp:${VERSION}
                            docker rmi 34.238.232.93:8083/springapp:${VERSION}
                        '''
                    }
                }
            }
        }

we can refresh & check on Nexus repo:
---------------------
E-mail alert configuring to jenkins:
==================
github:
https://github.com/vikash-kumar01/CICD_Java_gradle_application/wiki/Configuring-mail-server-in-Jenkins-(-Gmail-)

Manage Jenkins >> plugins >>
installed:default will be downloaded

Email Extension Plugin 
------
Manage Jenkins >> E-mail Notification >>
SMTP server:
smtp.gmail.com

click>>advanced:

check: Use SMTP Authentication
username: (sender usermail):
devopsmails1@gmail.com

same mail >> manage account>>
apps password:
select app:
other:
Jenkins 
click Generate
kcqusaxwqdmwvhid


copy pate in email-notification >> password:
kcqusaxwqdmwvhid

check: Use SSL


Test configurations:
test email-recepient:
devopsmails1@gmail.com
Click: test configure
result will be succeeded and mail would be sent to recepient
   ----------------

mandatory:
To send the custom mails as per pipeline success or fails

 manage Jenkins >> system>>Extended E-mail Notification>>
SMTP server
smtp.gmail.com
SMTP Port
465

Credentials:

click: Add>> Jenkins >>
kind: 
username & password

Username:
devopsmails1@gmail.com
password:(apps password created one copied)
kcqusaxwqdmwvhid
id:
gmail_auth
des:
gmail_auth

credentials:
select the created user id gmail_auth
          
Default Content Type
HTML(text/html)

appy & save

-----------------------

Installing Helm datree on Jenkins server:
============
sudo su
passwd jenkins
sudo su
~
-----

# HELM INSTALL 

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm 
to check helm is installed properly


# Datree.io Install 
apt-get install unzip
curl https://get.datree.io | /bin/bash
datree version
----------------

installing datree.io for Identifying misconfigs in Helm Charts using Datree
https://hub.datree.io/
integrations>>helm plugins >>
on jenkins:
su - jenkins


helm plugin install https://github.com/datreeio/helm-datree
helm plugin update datree
helm datree test [CHART_DIRECTORY] 
ex: .
helm datree test .

datree block:

stage ('Identifying misconfigs in Helm Charts using Datree'){
            steps{
                script{
                   dir('kubernetes/myapp/') {
                    
                        sh 'helm datree test .'
                    } 
                }
            }

        }
---
Pushing passed to helm charts to helm hosted nexus-repo
=====================
on Nexus dash board:
Settings>> Rositories >> create repo >> click on : helm(hosted)
reponame: helm-repo
click: Create repo
-------
On jenkinsfile:
----------
pushing helm repo block:
github:
https://github.com/vikash-kumar01/CICD_Java_gradle_application/wiki/Creating-Helm-hosted-repository-in-Nexus-and-Pushing-the-helm-charts

stage('Pushing the helm to charts Nexus repo'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus_cred_pwd', variable: 'nexus_pwd')]) {
                        dir('kubernetes/') {
                            sh'''
                            helmversion=$(helm show chart myapp | grep version | cut -d: -f 2| tr -d ' ')
                            tar -cvzf myapp-${helmversion}.tgz myapp/
                            curl -u admin:$nexus_pwd http://34.238.232.93:8081/repository/helm-repo/ --upload-file myapp-${helmversion}.tgz -v
                            '''
                        }    

                    }

                }
            }
        }
    }
=======================Jenkins file=====================
pipeline{

    agent any
    environment{

        VERSION="${env.BUILD_ID}"

    }
    stages {

        stage ('Sonar Quality Check'){

            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh " mvn clean package sonar:sonar"
                    }

                }
            }
        }

        stage ('Sonar Quality Gate status'){

            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }

        stage ('Docker image build & docker push Nexus repo'){

            steps{
                
                script{
                    withCredentials([string(credentialsId: 'nexus_cred_pwd', variable: 'nexus_pwd')]) {
                        sh '''
                            docker build -t 34.238.232.93:8083/springapp:${VERSION} . 

                            docker login -u admin -p  $nexus_pwd 34.238.232.93:8083
                            docker push 34.238.232.93:8083/springapp:${VERSION}
                            docker rmi 34.238.232.93:8083/springapp:${VERSION}
                        '''
                    }
                }
            }
        }

        stage ('Identifying misconfigs in Helm Charts using Datree'){
            steps{
                script{
                   dir('kubernetes/myapp/') {
                        withEnv(['DATREE_TOKEN=2e926442-314b-4166-8007-9e47dd366c14']) {
                        sh 'helm datree test .'
                        }
                    } 
                }
            }
        }
        stage('Pushing the helm to charts Nexus repo'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus_cred_pwd', variable: 'nexus_pwd')]) {
                        dir('kubernetes/') {
                            sh'''
                            helmversion=$(helm show chart myapp | grep version | cut -d: -f 2| tr -d ' ')
                            tar -cvzf myapp-${helmversion}.tgz myapp/
                            curl -u admin:$nexus_pwd http://34.238.232.93:8081/repository/helm-repo/ --upload-file myapp-${helmversion}.tgz -v
                            '''
                        }    

                    }

                }
            }
        }
    }
    post {
		always {
			mail bcc: '',
            body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", 
            cc: '', 
            charset: 'UTF-8', 
            from: '', mimeType: 'text/html', 
            replyTo: '', 
            subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", 
            to: "devopsmails1@gmail.com";  
		}
	}
}
===================Docker file=================
FROM maven as build
WORKDIR /app
copy . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/*.jar /app/
EXPOSE 8080
CMD ["java", "-jar","/app/*.jar"]
=======================
