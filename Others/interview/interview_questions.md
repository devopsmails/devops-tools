28/08/2023 
-----------------
1.How do you restrict the port access from linux firewall apart from SG, NACL, VPC?  
  ufw would auto installed as firewall  
  ufw allow / deny port number  
--------------------

2. How can a user ssh with out using .pem file?  
  2 ways possible  
    - /etc/ssh/sshd_config  
    - PasswordAuthentication yes  
      PermitRootLogin yes  
      sudo service sshd restart  
      ssh username@ec2-instance-ip-address  
---
   
In the given scenario, it is possible for user Ramu to SSH to the Ubuntu instance without a .pem file if you have previously added their  
public key to the instance's authorized_keys file.To do this, you would first need to generate the public key for Ramu's account.   
You can do this by running the following command:  

ssh-keygen -t rsa -b 4096  
ssh-copy-id ramu@ubuntu-ip  
ssh ramu@ubuntu-ip  
------------

4. How to make one docker-compose to communicate with other docker-compose file?  
  To make one Docker Compose to communicate with other Docker Compose file, you can use the following steps:  
--------------------
Create a common network in the Docker Compose file of one project.  
Set the network to connect to in the other project's Docker Compose.  
Set up the network for all services we want to be connect.  
Here is an example of how to do this:  

# Project 1 Docker Compose file  
version: '3.7'  
services:  
  web:  
    image: nginx:latest  
    networks:  
      - common  

# Project 2 Docker Compose file  
version: '3.7'  
services:  
  db:  
    image: postgres:latest  
    networks:  
      - common  

networks:  
  common:  

5. java -jar jenkins.war - This commands runs an application but when closes application stops. How to create a service & run  continously?  
-----------------
Create a systemd unit file.  
Enable and start the service.  
Here is an example of a systemd unit file for a service that runs the java -jar jenkins.war command:  

[Unit]  
Description=Jenkins Service  
After=network.target  

[Service]
Type=simple  
ExecStart=/usr/bin/java -jar jenkins.war  
Restart=always  

[Install]
WantedBy=multi-user.target  
Once you have created the systemd unit file, you can enable and start the service using the following commands:  

sudo systemctl enable jenkins.service  
sudo systemctl start jenkins.service  
----------

29/08/2023  
------------
1. What were using ansible for? Were you writting playbooks & what kind of ploybooks your were writting?Were you using ansible-roles?  
Install and configure the Apache web server: This playbook would install and configure the Apache web server on a group of web servers. The playbook would first install the Apache package, then configure the Apache configuration file.  
---  
- hosts: webservers  
  tasks:  
  - name: Install Apache  
    apt:  
      name: apache2  
      state: present  

  - name: Configure Apache  
    file:    
      path: /etc/apache2/apache2.conf  
      state: edited  
      content: |  
        ServerName www.example.com  
Deploy a Java application: This playbook would deploy a Java application to a group of application servers. The playbook would first download the Java  
 application, then install it on the application servers.  
---
- hosts: applicationservers  
  tasks:  
  - name: Download Java application  
    wget:   
      url: https://example.com/java-application.jar  
      dest: /opt/java-application.jar  

  - name: Install Java application  
    shell: java -jar /opt/java-application.jar  
Update the firewall rules: This playbook would update the firewall rules on a group of firewalls. The playbook would first get the current firewall rules, then update the rules as needed.  
---  
- hosts: firewalls  
  tasks:  
  - name: Get firewall rules  
    shell: iptables -L  
    register: firewall_rules  

  - name: Update firewall rules  
    shell: iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT  
    when: firewall_rules.stdout.find('80') == -1  
Create a new user and add them to a group: This playbook would create a new user and add them to a group. The playbook would first create the user  
 account, then add the user to the group.  
---
- hosts: all  
  tasks:  
  - name: Create user  
    user:  
      name: new_user  
      state: present  

  - name: Add user to group  
    user:  
      name: new_user  
      group: sudo  
      state: present  
Patch systems with the latest security updates: This playbook would patch a set of systems with the latest security updates. The playbook would first get a list of the latest security updates, then install the updates on the systems.  
---
- hosts: all 
  tasks:  
  - name: Get security updates  
    apt:  
      name: security_updates  
      state: latest  

  - name: Install security updates  
    apt:  
      name: security_updates  
      state: present  
These are just a few examples of the types of Ansible playbooks that I have written. Ansible playbooks can be used to automate a wide variety of tasks, so the possibilities are endless.  
------------------
2. what image you use for hostintg https?  
------------------- 
When it comes to hosting an HTTPS-enabled application using Docker, the choice of the Docker image depends on a few key factors. One of the most popular   choices for hosting web applications is using the NGINX web server. NGINX is well-known for its performance, scalability, and support for SSL/TLS  
 encryption, which is crucial for HTTPS.  

For hosting HTTPS-enabled applications using Docker, I would recommend using the official NGINX Docker image. The official images are maintained by the  
 NGINX team and are regularly updated to ensure security and compatibility.  

docker pull nginx  
docker run -d \  
  --name my-nginx-container \  
  -p 443:443 \  
  -v /path/to/your/ssl/certificates:/etc/nginx/ssl \  
  -v /path/to/your/app:/usr/share/nginx/html \  
  nginx  
----------------------------- 
3. How do you configure Nexus & How do  you access nexus?  
-----------------------------
Configuring Nexus, a repository manager used for storing and managing artifacts, involves several steps. Here's a general outline of how to configure  
 Nexus and how to access it:  

1. Install Nexus:  

Download the Nexus Repository Manager from the official website.  
Extract the downloaded package to a location on your server.  
2. Configure Nexus:  

Open the nexus.properties file located in the conf directory of your Nexus installation.  
Configure settings such as the repository storage location, base URL, and other parameters according to your requirements.  
Optionally, configure security settings, such as enabling LDAP integration or setting up user roles and permissions.  
3. Start Nexus: 

Navigate to the bin directory of your Nexus installation. 
Run the appropriate startup script (nexus or nexus.exe) to start the Nexus server. 
4. Access Nexus Web Interface:  

Open a web browser.  
Access the Nexus web interface using the URL you configured in the nexus.properties file. By default, it's often http://localhost:8081.  
You will be presented with the Nexus login page.  
5. Log in to Nexus: 

If you haven't configured security settings, you can log in with the default admin credentials (username: admin, password: admin123). However, it's  
 recommended to change this password immediately.  
If you've configured LDAP or other authentication methods, log in using the appropriate credentials.  
6. Configure Repositories:  

Once logged in, you can configure various repositories such as Maven, Docker, NuGet, etc., based on your needs.  
Configure repository settings, including storage, access control, and proxy settings for remote repositories.  
7. Access Repositories:  

Depending on the repository types you've configured, you can now start uploading and managing artifacts.  
For example, if you've set up a Maven repository, you can configure your Maven settings.xml to point to your Nexus repository for artifact deployment and  retrieval.  
8. Secure Nexus:  

It's crucial to secure your Nexus installation to prevent unauthorized access and data breaches.  
Update the default admin password and create strong passwords for other users.  
-----------------------------
4. How do you attach/create an instance in existing subnet?  
-----------------------------

provider "aws" {  
  region = "us-east-1"  # Replace with your desired region  
}  

resource "aws_instance" "example_instance" {  
  ami           = "ami-12345678"  # Replace with your desired AMI ID  
  instance_type = "t2.micro"      # Replace with your desired instance type  
  subnet_id     = "subnet-12345678"  # Replace with your existing subnet ID***********  
}  

terraform init  
terraform plan  
terraform apply  
-----------------------------
6. How do you configure cloud watch to n number instances for 2 way communications using terraform?  
-----------------------------
resource "aws_instance" "communication_instance" {**************  
  count        = 10  
  ami          = "ami-12345678"  
  instance_type = "t2.micro"  
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_instance_role.name**************  

  // Other instance configuration...  
}

resource "aws_cloudwatch_metric_alarm" "communication_cpu_alarm" {  
  count               = 10  
  alarm_name          = "CommunicationCpuAlarm-${count.index}"  
  comparison_operator = "GreaterThanOrEqualToThreshold"  
  evaluation_periods  = "2"  
  metric_name         = "CPUUtilization"  
  namespace           = "AWS/EC2"  
  period              = "300"  
  statistic           = "Average"  
  threshold           = "80"  # Set your desired threshold  
  alarm_description  = "Alarm triggered for high CPU utilization"  
  
  dimensions = {  
    InstanceId = element(aws_instance.communication_instance.*.id, count.index)  
  }  

  alarm_actions = [aws_sns_topic.notification_topic.arn]  
}

resource "aws_sns_topic" "notification_topic" {  
  name = "CommunicationCpuNotificationTopic" 
}
-----------------------------

06-09-2023 - Benz - c2h  
------------------------
K8  
----
1.What is your activities in kubernetes ?  
---------------------

Created and managed a Kubernetes cluster on AWS using Terraform.  
Automated the deployment of a web application to Kubernetes using Jenkins and Helm.  
Secured a Kubernetes cluster using RBAC and Network Policies.  
Monitored a Kubernetes cluster using Prometheus and Grafana.  
Troubleshooting a problem with a Kubernetes application using kubectl.  
Developed and deployed a Kubernetes plugin to automate the deployment of applications. 
Worked with stakeholders to design a Kubernetes solution for a new application  
--------------

2.What is Static pod?  
------------
Always bound to a specific node.  
Can be used to run system services or pods that need to be isolated from the rest of the cluster.  
Simple to manage because they are not managed by the Kubernetes control plane.  
Not scalable because they are not managed by the Kubernetes control plane.  
Not as flexible as pods that are managed by the Kubernetes control plane.  
------------
3.What is resource quota? 
--------------
A resource quota is a Kubernetes object that limits aggregate resource consumption per namespace.  

Here is a more detailed explanation:

A resource quota is an object in Kubernetes that limits the amount of resources that can be consumed by a group of objects. 
Resource quotas can be used to limit the number of pods, the amount of CPU or memory, or the amount of storage that can be used by a namespace.  
Resource quotas are enforced by Kubernetes when pods are created or updated. If a pod tries to create more resources than the quota allows, the pod will   be rejected.  
Resource quotas can be used to prevent resource contention and ensure that each tenant has a fair share of resources.  
---------------------

4.Scurity Condext?  
---------
A security context defines privilege and access control settings for a Pod or Container.  

A security context is a set of attributes that define the privileges and access control settings for a pod or container.  
Security context settings include, but are not limited to:  
The ability to run as root  
The ability to access certain filesystems  
The ability to use certain network ports  
The ability to create new processes  
Security contexts are used to control the security of pods and containers.  
They can be used to prevent unauthorized access to resources, to prevent malicious code from being executed, and to protect the integrity of the system.  
-------------
5.What is services in K8?  
---------------
A service is a logical abstraction of a set of pods that defines a single point of access for a set of pods.  

A service is a Kubernetes object that defines a single point of access for a set of pods.  
The service is identified by a label selector, which is a set of labels that the pods must have in order to be included in the service.  
The service defines a port that the pods are listening on, and a cluster IP address that is used to access the service.  
The service can also be configured to use a load balancer to distribute traffic across the pods.  
Services are used to expose pods to the outside world, or to make them accessible to other pods in the cluster.  
------------------
6. What is Budgetting in K&? How many types of budgetting?
--------------
Pod budgets: Pod budgets limit the amount of resources that a pod can consume.  
Namespace budgets: Namespace budgets limit the amount of resources that a namespace can consume.  

Here are the names of the budgeting objects in Kubernetes:  

PodDisruptionBudget: This object defines a budget for the number of pods that can be unavailable in a deployment or replica set.  
ResourceQuota: This object defines a budget for the amount of resources that can be consumed by a namespace.  
LimitRange: This object defines a budget for the amount of resources that can be consumed by a pod.  
---------
7. what is Control managaer ?
---------------------
The controller manager is a daemon that embeds the core control loops shipped with Kubernetes.  

Here is a more detailed explanation:  

The Kubernetes control plane is responsible for managing the cluster, including creating, deleting, and updating resources.  
The controller manager is a daemon that runs in the control plane and is responsible for running the core control loops.  
The core control loops are responsible for ensuring that the desired state of the cluster is maintained.  
The controller manager also runs other controllers, such as the replication controller, the endpoint controller, and the service account controller.  
--------------------
09-10-2023 US
---------------
Intro?
How are you using kubernetes? for ?
How are you using Terraform? for ?
504 ?
