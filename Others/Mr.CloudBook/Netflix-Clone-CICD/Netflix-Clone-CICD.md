Netflix Clone CI/CD Pipeline | Jenkins | Docker | Kubernetes | Monitoring | DevSecOps 
```
Doc Blog: https://mrcloudbook.hashnode.dev/devsecops-netflix-clone-ci-cd-with-monitoring-email
yt: https://youtu.be/pbGA-B_SCVk?si=MZhdC6XCTZABgIn-
``` 
Jenkins-Instance:
---------
```
aws-ec2-ubuntu-22.04
all-traffic
t2.large
30 GB mem
```
Grafana-promethous instance:
------
```
aws-ec2-ubuntu-22.04
all-traffic
t3.medium
12 GB mem
```
on Jenkins cli
Long Term Support release
java installation:
-------

```
sudo apt update -y
sudo apt install openjdk-17-jdk -y
```
Debian/Ubuntu
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins

jenkins --version

sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
docker version
sudo chmod 777 /var/run/docker.sock
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
docker ps
j-INSTANCE-p-IP:8080
COPY-PASTE THE INITIAL ADMIN PASSWORD
INSTALL SUGGESTED PLUGINS
SKIP & CONTINUE AS ADMIN
ENTER THE INTITIAL ADMIN PWD
  username: "admin"
start using jenkins

Change the admin pwd on jenins  Dash-board:
-------------------------------------
admin tab >>
configure >>
Password >>
  enter passwd: Admin
  confirm pwd : Admin
  apply & save
---------
j-INSTANCE-p-IP:8080
UNAME: Admin
pwd: Admin
```
On Sonarqube webbrowser
```
j-Instance_p-ip:9000
Uname: admin
pwd: admin

Update new pwd:
---------------
old pwd: admin
new pwd: Admin
confirm pwd: Admin
update
```
on jenkins CLI  
------------
Install Trivy  
---------------
```
vi trivy.sh
----------
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y
----------
chmod +x trivy.sh
sh trivy.sh
```

Create TMDP API KEY:
----------------
```
Uname: sureshdev1
PWD: Devops@1
Account Profile pic >> Settings >> API:
  Create >>: Developer: Accept >>
  Type of USE: Desktop Application
  Application Name: Demo-app
  submit>>
  API Key: ff7b18fd132db08968c63c42be8fc12f
``` 
Step 4 — Install Prometheus and Grafana On the new Server:
```
First of all, let's create a dedicated Linux user sometimes called a system account for Prometheus. Having individual users for each service serves two main purposes:

It is a security measure to reduce the impact in case of an incident with the service.

It simplifies administration as it becomes easier to track down what resources belong to which service.

To create a system user or system account, run the following command:
```
```
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus
```
```--system - Will create a system account.
--no-create-home - We don't need a home directory for Prometheus or any other system accounts in our case.
--shell /bin/false - It prevents logging in as a Prometheus user.
Prometheus - Will create a Prometheus user and a group with the same name.

Let's check the latest version of Prometheus from : https://prometheus.io/download/

You can use the curl or wget command to download Prometheus.
```
```
wget https://github.com/prometheus/prometheus/releases/download/v2.48.0/prometheus-2.48.0.linux-amd64.tar.gz
tar -xvf prometheus-2.48.0.linux-amd64.tar.gz
```
Usually, you would have a disk mounted to the data directory. For this tutorial, I will simply create a /data directory. Also, you need a folder for Prometheus configuration files.
```
sudo mkdir -p /data /etc/prometheus
```
Now, let's change the directory to Prometheus and move some files.
```
cd prometheus-2.48.0.linux-amd64
```
First of all, let's move the Prometheus binary and a promtool to the /usr/local/bin/. promtool is used to check configuration files and Prometheus rules.
```
sudo mv prometheus promtool /usr/local/bin/
```
Optionally, we can move console libraries to the Prometheus configuration directory. Console templates allow for the creation of arbitrary consoles using the Go templating language. You don't need to worry about it if you're just getting started.
```
sudo mv consoles/ console_libraries/ /etc/prometheus/
```
Finally, let's move the example of the main Prometheus configuration file.
```
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
```
To avoid permission issues, you need to set the correct ownership for the /etc/prometheus/ and data directory.
```
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
```
You can delete the archive and a Prometheus folder when you are done.
```
cd ..
rm -rf prometheus-2.47.1.linux-amd64.tar.gz
prometheus --version
prometheus --help
```
We're going to use Systemd, which is a system and service manager for Linux operating systems. For that, we need to create a Systemd unit configuration file.
```
sudo vim /etc/systemd/system/prometheus.service
```
prometheus.service
```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
```
```
Let's go over a few of the most important options related to Systemd and Prometheus. Restart - Configures whether the service shall be restarted when the service process exits, is killed, or a timeout is reached.
RestartSec - Configures the time to sleep before restarting a service.
User and Group - Are Linux user and a group to start a Prometheus process.
--config.file=/etc/prometheus/prometheus.yml - Path to the main Prometheus configuration file.
--storage.tsdb.path=/data - Location to store Prometheus data.
--web.listen-address=0.0.0.0:9090 - Configure to listen on all network interfaces. In some situations, you may have a proxy such as nginx to redirect requests to Prometheus. In that case, you would configure Prometheus to listen only on localhost.
--web.enable-lifecycle -- Allows to manage Prometheus, for example, to reload configuration without restarting the service.

To automatically start the Prometheus after reboot, run enable.
```
```
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
```

Suppose you encounter any issues with Prometheus or are unable to start it. The easiest way to find the problem is to use the journalctl command and search for errors.
```
journalctl -u prometheus -f --no-pager
```

Now we can try to access it via the browser.
```
<public-ip:9090>
```
Go to status >> Targets = How many are connected for monitoring
-------------------
Install Node Exporter on prometheous Ubuntu 22.04
---------------------------------
Next, we're going to set up and configure Node Exporter to collect Linux system metrics like CPU load and disk I/O. Node Exporter will expose these as Prometheus-style metrics. Since the installation process is very similar, I'm not going to cover as deep as Prometheus.

First, let's create a system user for Node Exporter by running the following command:

```
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

```
You can download Node Exporter from the same page.

Use the wget command to download the binary.
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
```
Extract the node exporter from the archive.
```
tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz
```
Move binary to the /usr/local/bin.
```
sudo mv \
  node_exporter-1.6.1.linux-amd64/node_exporter \
  /usr/local/bin/
```
Clean up, and delete node_exporter archive and a folder.

```
rm -rf node_exporter*
```
Verify that you can run the binary.
```
node_exporter --version
```
Node Exporter has a lot of plugins that we can enable. If you run Node Exporter help you will get all the options.


```
node_exporter --help
```
--collector.logind We're going to enable the login controller, just for the demo.

Next, create a similar systemd unit file.
```
sudo vim /etc/systemd/system/node_exporter.service
```
```
node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target
```

Replace Prometheus user and group to node_exporter, and update the ExecStart command.
To automatically start the Node Exporter after reboot, enable the service.
```
sudo systemctl enable node_exporter
```
Then start the Node Exporter.
```
sudo systemctl start node_exporter
```
Check the status of Node Exporter with the following command:
```
sudo systemctl status node_exporter
```
If you have any issues, check logs with journalctl
```
journalctl -u node_exporter -f --no-pager
```
At this point, we have only a single target in our Prometheus. There are many different service discovery mechanisms built into Prometheus. For example, Prometheus can dynamically discover targets in AWS, GCP, and other clouds based on the labels. In the following tutorials, I'll give you a few examples of deploying Prometheus in a cloud-specific environment. For this tutorial, let's keep it simple and keep adding static targets. Also, I have a lesson on how to deploy and manage Prometheus in the Kubernetes cluster.

To create a static target, you need to add job_name with static_configs.
```
sudo vim /etc/prometheus/prometheus.yml


prometheus.yml
  - job_name: node_export
    static_configs:
      - targets: ["localhost:9100"]
```

By default, Node Exporter will be exposed on port 9100.

Since we enabled lifecycle management via API calls, we can reload the Prometheus config without restarting the service and causing downtime.

Before, restarting check if the config is valid.
```
promtool check config /etc/prometheus/prometheus.yml
```
Then, you can use a POST request to reload the config.
```
curl -X POST http://localhost:9090/-/reload
```

Check the targets section
```
http://<ip>:9090/targets
```

Install Grafana on Grafana instance Ubuntu 22.04
--------------------------
To visualize metrics we can use Grafana. There are many different data sources that Grafana supports, one of them is Prometheus.

First, let's make sure that all the dependencies are installed.
```
sudo apt-get install -y apt-transport-https software-properties-common
```
Next, add the GPG key.

```
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
```
Add this repository for stable releases.
```
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```
After you add the repository, update and install Garafana.
```
sudo apt-get update
sudo apt-get -y install grafana
```
To automatically start the Grafana after reboot, enable the service.
```
sudo systemctl enable grafana-server
```
Then start the Grafana.
```
sudo systemctl start grafana-server
```
To check the status of Grafana, run the following command:
```
sudo systemctl status grafana-server
```
Go to http://<ip>:3000 and log in to the Grafana using default credentials. The username is admin, and the password is admin as well.
```
username admin
password admin
changed PWD adminadmin
```
When you log in for the first time, you get the option to change the password.

To visualize metrics, you need to add a data source first.
```
data source >> 
  Time series databases >> prometheus(shows prometheus datails)
  Connection:
    Prometheus server URL: http://18.144.171.10:9090/(premethes ip:9090)
    save & test >> Successfully queried the Prometheus API.
Import dash board: (Visualize)
  top right + :
    import dash board >>
    id: 1860(best for complete info)>> Load:
                                      select prometheus >> import(show visual info of prometheus server)
```
Configuring Jenskins server with Premetheus along with grafana
-----------------------------------------------------------
```
Jenkins Dash board: 
Dashboard >> Manage Jenkins>> 
Plugins:
  Prometheus metrics   install
  Jenkins needs be restarted.
  same installing plugin page: restart
  login back to jenkins

Jenkins Dash board:
  manage jenkins >> system >> search for: Prometheus >>
      check all boxez(2) except ""Disable metrics"" & with no changes >> save & apply
```
Adding Jenkins to prometheus.yml on prometheus server
```
sudo vi /etc/prometheus/prometheus.yml
```
paste below
```
  - job_name: 'jenkins'
    metrics_path: '/prometheus'
    static_configs:
      - targets: ['<jenkins-ip>:8080']  ## add the jenkins ip
```
Syntax check:
```
promtool check config /etc/prometheus/prometheus.yml
```
Then, you can use a POST request to reload the config.
```
curl -X POST http://localhost:9090/-/reload
```
prometheus dash board: settings: targets >> refresh: shows jenkins up in 5 sec
```
http://18.144.171.10:9090/targets
```
======================================
======================================
Email Integration with jenkins & plugin setup
-------------------------------
```
Manage jenkins >> Manage plugins >> 
  install: Email Extension Template
  open gamil >> propfile >> manage account >> security >> enable 2 step verification
  gmail>> manage account search: app passwords: 
    appname: Jenkins >> create
    pwd: cdcp mrnf snbs wzug
```
Adding gmail credentials in jenkins
---------------------
Email credential setup on jenkins
```
Dashboard >> Manage Jenkins >> Credentials >> System >> Global credentials (unrestricted):
  username & passwd
  username: devopsmails1@gmail.com
  pwd: cdcp mrnf snbs wzug #(gmail create password)
  id: mail >> create
```
Email config & mail Test on jenkins
----------------------
```
Dashboard >> Manage Jenkins >> system search:
  E-mail Notification
    SMTP server: smtp.gmail.com
    advanced:
      check: Use SMTP Authentication
        user name: devopsmails1@gmail.com
        Password:  cdcp mrnf snbs wzug #(gmail create password)
      check: use ssl
      SMTP Port: 465
      check: Test config
            Test e-mail recipient: devopsmails1@gmail.com   >>  Test configuration

Dashboard >> Manage Jenkins >> system search:
Extended E-mail Notification:
SMTP server: smtp.gmail.com
smto port: 465
advanced:
  credential: select cread saved earleir(  user name: devopsmails1@gmail.com )
Default Content Type: HTML
Default triggers: always >> 
apply &  save  
```
=========================
=========================
7.Installing plugins openjdk, nodejs, sonarqube

Goto Manage Jenkins >> Plugins >>  Available Plugins >> 

```
Install below plugins

1 → Eclipse Temurin Installer (Install without restart)

2 → SonarQube Scanner (Install without restart)

3 → NodeJs Plugin (Install Without restart)
```
configuring eclipse temurin & nodejs on jenkins tools
```
Dashboard >> Manage Jenkins >> Tools:
  
JDK installations:
  Add JDK:
    NAME: jdk17
      install autometically:
        Install from adoptium.net:
          version: jdk-17.0.8.1+1

NodeJS installations:
Add nodeJs
  Name: node16
  Install automatically
  Install from nodejs.org
  NodeJS 16.2.0

>> apply & save
```
=======================
========================
8.Configure Sonar Server in Manage Jenkins

```
login sonarqube:
  pub ip: 9000
sonar Dash board >> Administration >> user >>:
  token >> name: jenkins >> Generate
  token = squ_584ce430eec35d9e8195b3e230ea72fd5f607aa8

Jenkins Dash board:
  manage jenkins >> Creadentials >> Gloabal >> Secret text >> pate: squ_584ce430eec35d9e8195b3e230ea72fd5f607aa8 #(secret token)
  id = sonar-token >> save
```
Configuring sonar scanner with jenkins

```
manage jenkins >> system >> sonar scanners >>
SonarQube installations:
  name: sonarqube-server
  server URL: http://54.151.67.235:9000
  Server authentication token: SELECT sonar-token >> apply & save
```
Configuring sonar version
```
manage jenkins >> tools >> Sonar scanners >>
name: sonar-scanner
version: Sonarqubescanner: 5.0.1.3006 >> apply & save
```
Configuring jenkins with sonar webhook for providing quality report feedback to Jenkins:
---------------------------
```
sonar dash board >> Configuratins >> Web hooks >> Create >> Name: Jenkins
                                                            URL: http://51.20.82.52:8080/sonarqube-webhook
                                                            >> create
```

Creating a first pipeline:
----------------
```
Jenkins Dash board >> new item >> Enter an item >>
name: Netflix
pipeline
```

jenkinsfile
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
    }
}
```
Step 9 — Install OWASP Dependency Check Plugins for Dependency check & vulnerbility:
------------------
```
jenkins >> manage jenkins >> plugins >> name: OWASP Dependency-CheckVersion >> install
jenkins >> manage jenkins >> tools >> Dependency-Check installations:
      add Dependency check >>
          Name: DP-Check
          install auto >>
              install from github >> dependency-check-6.5.1  >> apply & save
```
OWASP Dependency fs scan & trivy fs scan stages are added to pipeline
```
jenkinsfile

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
    
    }
    
    post {
     always {
        emailext attachLog: true,
            subject: "'${currentBuild.result}'",
            body: "Project: ${env.JOB_NAME}<br/>" +
                "Build Number: ${env.BUILD_NUMBER}<br/>" +
                "URL: ${env.BUILD_URL}<br/>",
            to: 'devopsmails1@gmail.com',
            attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
        }
    }
}

```
Step 10 — Docker Image Build and Push

```
Install docker plugins
jenkins >> manage Jenkins >> plugins >>
Docker
Docker Commons
Docker Pipeline
Docker API
docker-build-step >> install 
```

Adding Docker hub creds to jenkins credentials
```
jenkins >> manage Jenkins >> credentials:
username: sureshdevops1
pwd: Devops@11
id: docker-hub >> save
```

Add docker tools to jenkins 

```
jenkins >> manage Jenkins >> tools:
Docker installations >>
name: docker
install auto metically >>
  Download from docker.com
  latest >> apply & save
```
Generate docker syntax with docker Rigistry

```
jenkins  pipeline syntax:
Sample Step: WithDockerRigistry: Sets up Docker Registry Endpoint
Registry credentials: Select the docker hub creds
Docker installation: docker

copy & paste in the docker state

withDockerRegistry(credentialsId: 'docker-hub', toolName: 'docker') {
    // some block
}

```
Pipeline till docker push:

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
    }
    post {
     always {
        emailext attachLog: true,
            subject: "'${currentBuild.result}'",
            body: "Project: ${env.JOB_NAME}<br/>" +
                "Build Number: ${env.BUILD_NUMBER}<br/>" +
                "URL: ${env.BUILD_URL}<br/>",
            to: 'devopsmails1@gmail.com',
            attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
        }
    }
}
```
-----------------------------------
Step 11 — Kuberenetes Setup
Connect your machines to Putty or Mobaxtreme

Take-Two Ubuntu 20.04 instances one for k8s master and the other one for worker.

Install Kubectl on Jenkins machine also.

Kubectl is to be installed on Jenkins also+-
```
vi kube.sh
-----------
sudo apt update
sudo apt install curl -y
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
---
chmod +x kube.sh
./kube.sh
---
```
Launch 2 ec2 ubuntu 20.04 LTS instances for K8'S Master & Worker:
---
```
ubuntu 20.04
all trafic
t3.medium
no of instances 2 >> launch instances
```
k8's Master & Worker node:
----------
```
sudo apt-update -y
sudo hostnamectl set-hostname Master/Worker
exec bash(Reloads)
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo tee /etc/apt/sources.list.d/kubernetes.list <<EOF
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo snap install kube-apiserver
```
Only on Master node
-----------
```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get nodes
```
only on Worker node
---------
```
sudo kubeadm join 172.31.17.52:6443 --token rtjifx.qln40vxbqpwn2vwl \
        --discovery-token-ca-cert-hash sha256:83ee3108fa705b95f5854a320e069d6a72544af517c0df799e535c7c593ff1bf
```
Install k8s plugins on jenkins dash board
-----------
```
plugins >>Avail plugins : 
Kubernetes
Kubernetes Client API
Kubernetes Credentials
Kubernetes CLI
Kubernetes Credentials Provider
>> install
```
Copying kube config file to secretfile and attach to Jenkins creds:
on master node:
```
cd .kube/
Copy the config file to Jenkins master or the local file manager and save it
copy it and save it in documents or another folder save it as secret-file.txt
---from start api-server to end == ----
```
Jenkins dash board
```
manage jenkins>>
creds >> global >> add creds >>
kind: Secret file
choose: secret-file.txt
Id: k8s
```
Install node port exporter on k8's master & worker nodes
----------------
```
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz

sudo mv \
  node_exporter-1.6.1.linux-amd64/node_exporter \
  /usr/local/bin/

rm -rf node_exporter*

node_exporter --version

node_exporter --help

sudo vim /etc/systemd/system/node_exporter.service
-------

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target

------------
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter
journalctl -u node_exporter -f --no-pager

```
Add static targets to only on Prometheous server
```
sudo vim /etc/prometheus/prometheus.yml
---
- job_name: node_export_k8_master
    static_configs:
      - targets: ["51.20.249.174:9100"]

  - job_name: node_export_k8_worker
    static_configs:
      - targets: ["13.49.80.9:9100"]

------------
promtool check config /etc/prometheus/prometheus.yml

curl -X POST http://localhost:9090/-/reload

prometheous ip:9090/targets

```
Deployting to container:
----------

pipeline +
-------
```
stage('Deploying to container'){
            steps {
                sh "docker run -d --name netflix sureshdevops1/netflix:latest"
            }
        }
```

Deploying to Kubernetes:
```
Change dir syntax:
-----
pipeline syntax generator:
changedir >>
path: kubernetes (bcz file is in same github directory if not in same need to provide the complete path here)
generate
copy
dir('Kubernetes') {
//
}
----------
generate kube config syntax
-------
pipeline syntax generator>>
withKubeConfig >> select secret file: secret-file.txt >> generate
copy >>
withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
//
} paste
--------------
Enter the kubectl executions commands for deploy & service.yml
----------
stage ('Deploying to K8s'){
            steps {
                script{
                    dir('Kubernetes') {
                        withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '',  
                         restrictKubeConfigAccess: false, serverUrl: '') {
                            sh "kubectl apply -f deployment.yml"
                            sh "kubectl apply -f service.yml"
                        }
                    }
                }
            }
        }

----------------
```
Master:
kubectl get svc
netflix app: 30007
browse worker node public ip:30007

Finally seen the success
![image](https://github.com/devopsmails/devops/assets/119680288/13f4c69c-fdb1-4e1a-9c09-e0d59a58cb1e)

Complete Pipeline:
----------
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
                sh "docker run -d --name netflix2 -p 8081:80 sureshdevops1/netflix:latest"
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
            subject: "'${currentBuild.result}'",
            body: "Project: ${env.JOB_NAME}<br/>" +
                "Build Number: ${env.BUILD_NUMBER}<br/>" +
                "URL: ${env.BUILD_URL}<br/>",
            to: 'devopsmails1@gmail.com',
            attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
        }
    }
}
```
