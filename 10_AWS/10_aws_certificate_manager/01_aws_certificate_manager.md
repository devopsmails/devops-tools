DIFF B/W HTTP & HTTPS:
========================
```
HTTP (Hypertext Transfer Protocol):  
================================
This is the foundation of web communication. It establishes a connection between your browser and a website to transfer data, but it does not encrypt that data.  Think of it like sending a postcard - anyone can read what's written on it. This is fine for browsing public information, but not ideal for sending sensitive data like passwords or credit card numbers.

HTTPS (Hypertext Transfer Protocol Secure):
========================================
 This is the secure version of HTTP. It uses a combination of HTTP with SSL/TLS (Secure Sockets Layer/Transport Layer Security) to encrypt the communication between your browser and the website.  This encryption scrambles the data, making it unreadable to anyone intercepting it in transit.  Imagine sending a sealed envelope - only the intended recipient can access the message inside.
```
WHAT IS AWS CERTIFICATE MANAGER (ACM)?
```
ACM is an AWS SERVICE that simplifies the process of managing SSL/TLS certificates for your websites and applications on AWS. 
SSL/TLS certificates are critical for securing communication between web servers and browsers, ensuring the encryption of data and establishing trust with users.
```
BENEFITS
```
Improved Security
Reduced Costs
Simplified Management
Automated Renewal
```     
image:  

Accessing DNS(binduvamsam.com) using simple routing with AWS CERTIFICATE MANAGER
================================================================================

```
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65536

2.CREATE 2 PUBLIC SUBNETS IN DIFFENT AZS IN SAME VPC
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
subnet2 >> 
      Subnet name: gabby-dev-pub-subnet-1-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> add new subnet

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

4. Route Table Creation
=====================
Public Route Table creation:
==========================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-subnet-rt id >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes
 
5. Create 1 ec2 instance in public subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-pub-ec2-1a
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-pub-subnet-1a
    Auto-assign public IP: Enable
    create security group name: gabby-dev-pub-ec2-sg
      description: gabby-dev-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 & http : 80 anywhere

  Configure storage: 8 GB
  
  Advanced details:
    user data:
#!/bin/bash
################
#installing apache2
###############
yes | sudo apt update 
yes | sudo apt upgrade 
yes | sudo apt install apache2
echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP address: </strong> $(hostname -I | cut -d "" -f1)</p>" > /var/www/html/index.html
sudo systemctl restart apache2

  Number of instances: 1 >> Create instance
**** Min atleast 10 minutes should wait after all the status chcecks have passed
**** pub ip: 3.110.207.103 on browser it'll show the private ip of that server as result.

6.CREATE TARGET GROUPS(instances will be attached)
=====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name:  gabby-dev-tg
    Protocol : Port: http: 80
    IP address type: Ipv4
    VPC: select: gabby-dev-vpc
    Protocol version: HTTP1
    Health checks:
      Health check protocol: http
      Health check path: / = root (on which path it should check the health stauts ex: 10.0.1.125:8080/home)
    Advanced health check settings: default 
      >> next >>
        Register targets:
          Available instances: select: gabby-dev-pub-ec2-1a >>
          include as pending below >> Create target group >>

7.APPLICATION LOAD BALANCER CREATION
=====================================
AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
Compare and select load balancer type: Application Load Balancer >> Create
Create Application Load Balancer >>Basic configuration >>
  Load balancer name: gabby-dev-alb
  Scheme: Internet facing
  IP address type: IPv4
  Network mapping:
    VPC: select gabby-dev-vpc
    Mappings: select 2 subnets: gabby-dev-pub-subnet-1a/1b
    Create a sg: gabby-dev-pub-ec2-sg
    ssh : anywhere ipv4 
    http : anywhere ipv4 >> Create sg  < or >
  Security groups: select gabby-dev-pub-ec2-sg
  Listeners and routing:
    Protocol:http
    port: 80
    select a target group: gabby-dev-alb-tg
  Review summary once again >> CREATE LOAD BALENCER 
  ***go to load balancer >> Wait for some time to complete provisioning & to become active
  *** select load balancer >> details >> copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com 
```
8.Created Hosted zone for binduvamsam.com
=================================
```
copy the same ns to dns provider custom ns place
```
CREATE A-RECORD USING AWS ROUTE-53 & ATTCHED WITH LOAD BALANCER
=========================================================
```
AWS >> Route 53 >> Hosted zones >>  binduvamsam.com >> Create record >>
Quick create record:
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-294273890.ap-south-1.elb.amazonaws.com/


    Routing policy: Simple routing >> Create Record >> Show status >>
**** Once the status is """INSYNC""" Copy the DNS name(binduvamsam.com) on browser & we can see it shows the private ip of the ec2 instance.
```
9.AWS CERTIFICATE MANAGER SETUP
==============================
```
AWS >> AWS CERTIFICATE MANAGER >> request certificates >> 
  Certificate type:Request a public certificate(As it's public faced app) >> next
Domain names: 
  Fully qualified domain name: binduvamsam.com
  Validation method: DNS validation 
  Key algorithm: RSA 2048
*** Refresh certificates: shows status:  Pending validation

CREATING CERTIFICATE RECORD IN ROUTE 53
================================
Click on certificate >> Create Record in Route 53 >> Create Records

Route 53 >> refresh to see the Certificate Record(CNAME)in records list
Validate: Copy the CNAME ONLY ID (_1c14ce9d539f5006a50fee5db5e97c31 ) 
  find on certificate page. it shows under CNAME section

**** Should refresh certificate staus to active

*** Load balancer is still has only for http. But now should open for https
ADD NEW LISTER FOR LOAD BALANCER
===========================
AWS >> LOAD BALANCER >> gabby-dev-alb >> Add listner >>
  Listener configuration: 
    Protocol: https : 443
    Routing actions: Forward to target groups
    Target group: gabby-dev-tg
    Secure listener settings:
      Default SSL/TLS server certificate: From ACM
      Certificate (from ACM): Select binduvamsam.com certificate >> Add

OPEN THE SECUITY GROUP FOR HTTPS IN LOAD BALANCER
============================================
AWS >> LOAD BALANCER >> gabby-dev-alb >> SECUITY >> Click sg: gabby-dev-pub-ec2-sg
  add inbound rules:
    https; 443 anywhere from ipv4 >> save rules

**** try accessing http://binduvamsam.com
**** try accessing https://binduvamsam.com

Redirect UNSECURED HTTP REQUEST TO SECURED HTTPS
==============================================
EC2 >> Load balancers >> gabby-dev-alb >> HTTP:80 listener>> defualt >> Edit listener:
  Routing actions: Redirect to URL
  Protocol: https : 443
  Status code: 301- permanently moved >> Save changes

*** Try accessing http://binduvamsam.com on web but still goes to https://binduvamsam.com




```