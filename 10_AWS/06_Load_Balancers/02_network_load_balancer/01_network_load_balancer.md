WHAT IS AWS NETWORK LOAD BALANCER?
==================================
```
An AWS Network Load Balancer is a highly performant service that distributes incoming traffic across multiple targets in your Amazon Virtual Private Cloud (VPC).  
It operates at layer 4 of the OSI model, meaning it routes traffic based on the transport protocol (TCP or UDP) and port number.
```
BENEFITS OF NLB
```
Increased Availability
High Performance
Scalability
Security
```
DIFF B/W LOAD BALANCER VS NETWORK LOAD BALANCER
================================================
```
Load balancer:
 is a broader term encompassing various types of services that distribute traffic across multiple resources. 
 There are application load balancers, network load balancers, and even gateway load balancers.

Network Load Balancer (NLB):
 is a specific type of load balancer that works at layer 4 of the OSI model, also known as the transport layer. 
 This means it routes traffic based on information like port numbers and IP addresses. 
 It doesn't interpret the content of the traffic itself.

```

NETWORK LOAD BALANCER SETUP:
=======================
```
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65536

2.CREATE 2 PUBLIC & 2 private SUBNETES IN DIFF AVAILABLITY ZONES IN THE SAME VPC
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
public:
========
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
    sunet2 >> 
      Subnet name: gabby-dev-pub-subnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> create subnets
private:
========
    sunet3 >> 
      Subnet name: gabby-dev-private-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.3.0/24 >> add new subnet
    sunet4 >> 
      Subnet name: gabby-dev-private-subnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.4.0/24 >> create subnets

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

4.public & private Route Table Creation
======================================
vpc >> route tables >> Route table settings
public:
======
    Name: gabby-dev-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-subnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes

private:
========
    Name: gabby-dev-private-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both private subnet ids >> Save association

5.Create 2 ec2 instance on public subnet az 1a & 1b
=======================================
AWS >> EC2 >> Launch an instance :
  Name: 
    gabby-dev-pub-ec2-1a
    gabby-dev-pub-ec2-1b
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: 
      gabby-dev-pub-subnet-1a
       gabby-dev-pub-subnet-1b
    Auto-assign public IP: Enable
    create security group name: 
      gabby-dev-pub-ec2-sg
      gabby-dev-pub-ec2-sg-2
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

**** take public ip(52.66.209.166 & 3.110.167.177) serch on web
**** wait for some time & refresh. Then you can see private ip of that server

ssh into ec2 gabby-dev-pub-ec2-1a & gabby-dev-pub-ec2-1b
===========================
sudo systemctl status apache2 - apache status running

sudo mkdir /var/www/html/foo
sudo mkdir /var/www/html/bar

ls /var/www/html/

sudo vi /var/www/html/foo/index.html
-------------

<h1> Hello from /foo - from ec2-2 (gabby-dev-pub-ec2-1b) </h1> 
<p> This is the confirmation message from /foo index.html </p>
----------

sudo vi /var/www/html/bar/index.html
-------------

<h1> Hello from /bar from ec2-2 (gabby-dev-pub-ec2-1b) </h1> 
<p> This is the confirmation message from /bar index.html </p>
----------
sudo systemctl restart apache2

http://52.66.209.166/ - shows only private ip address
http://52.66.209.166/foo/ - sows the message from foo page
http://52.66.209.166/bar/ - sows the message from bar page

  ex: Hello from /foo
  This is the confirmation message from /foo


http://3.110.167.177/- shows only private ip address
http://3.110.167.177/foo/ - sows the message from foo page
http://3.110.167.177/bar/ - sows the message from foo page

ex: Hello from /foo - from ec2-2 (gabby-dev-pub-ec2-1b)
This is the confirmation message from /foo index.html

6.CREATE TARGET GROUPS(not for http BUT for TCL)
=====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name: gabby-dev-alb-tg
    Protocol : Port: "" TCP"": 80 **** as we want set up Network load balancer
    IP address type: Ipv4
    VPC: select: gabby-dev-vpc
    Protocol version: HTTP1
    Health checks:
      Health check protocol: http
      Health check path: / = root (on which path it should check the health stauts ex: 10.0.1.125:8080/home)
    Advanced health check settings: default 
      >> next >>
        Register targets:
          Available instances: select: gabby-dev-pub-ec2-1a,gabby-dev-pub-ec2-1b >>
          include as pending below >> Create target group >>

7.Network load balancer setup
=============================
=====================================
  AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
  Compare and select load balancer type: *** Network Load Balancer *** >> Create
  Create Application Load Balancer >>Basic configuration >>
    Load balancer name: gabby-dev-nlb
    Scheme: Internet facing
    IP address type: IPv4
    Network mapping:
      VPC: select gabby-dev-vpc
      Mappings: select only 2 subnets: gabby-dev-pub-subnet-1a/1b
    Security groups: select gabby-dev-pub-ec2-sg
    Listeners and routing:
      Protocol:http ***
      port: 80
      select a target group: gabby-dev-alb-tg
    Review summary once again >> CREATE LOAD BALENCER 

    ***go to load balancer >> Wait for some time to complete provisioning & to become active
    *** select load balancer >> details >> 
    copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com 
    copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com/foo or /bar

  *** >> paste on browser new tab search>> """"refresh to view the changing traffic to when url/foo - > foo instance 
  when url/bar - > bar instance  """ (This is only possible with application load balancer)

8.APPLICATION LOAD BALANCER SET UP WITH 2 DIFF TARGET GROUPS
==========================
(URL/FOO -> SHOULD GO TO EC2-FOO
 URL/BAR -> SHOULD GO TO EC2-BAR BY DEFINING RULES)
============================================
Change the ec2 names as 
  gabby-dev-pub-ec2-1a-foo
  gabby-dev-pub-ec2-1b-bar (Just for identification)

ssh into both instances:
  remove 
  ""bar" directory from ec2 gabby-dev-pub-ec2-1a-foo
  ""foo" directory from ec2 gabby-dev-pub-ec2-1a-bar

cmd:
===
ec2 gabby-dev-pub-ec2-1a-foo
=================
sudo rm -rf /var/www/html/bar
ls /var/www/html    - shos bar is removed
sudo systemctl restart apache2

http://52.66.209.166/ - shows only private ip address
http://52.66.209.166/foo/ - sows the message from foo page
http://52.66.209.166/bar/ - error: page will not found ******

ec2 gabby-dev-pub-ec2-1a-bar
=================
sudo rm -rf /var/www/html/foo
ls /var/www/html    - shos foo is removed 
sudo systemctl restart apache2

http://3.110.167.177/- shows only private ip address
http://3.110.167.177/foo/ - error: page will not found *******
http://3.110.167.177/bar/ - sows the message from foo page

CREATE 2 TARGET GROUPS
=====================
gabby-dev-foo - routing to only ec2 gabby-dev-pub-ec2-1a-foo
gabby-dev-bar - routing to only ec2 gabby-dev-pub-ec2-1a-bar
====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name: 
      gabby-dev-foo
      gabby-dev-bar
    Protocol : Port: "" TCP"": 80 **** as we want set up Network load balancer
    IP address type: Ipv4
    VPC: select: gabby-dev-vpc
    Protocol version: HTTP1
    Health checks:
      Health check protocol: http
      Health check path: / = root (on which path it should check the health stauts ex: 10.0.1.125:8080/home)
    Advanced health check settings: default 
      >> next >>
        Register targets:
          Available instances: select: 
            gabby-dev-pub-ec2-1b-foo
            gabby-dev-pub-ec2-1a-bar >>
          include as pending below >> Create target group >>

Application load balancer creation
=================================
APPLICATION LOAD BALANCER CREATION
  =====================================
  AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
  Compare and select load balancer type: Application Load Balancer >> Create
  Create Application Load Balancer >>Basic configuration >>
    Load balancer name: gabby-dev-foo-bar-alb
    Scheme: Internet facing
    IP address type: IPv4
    Network mapping:
      VPC: select gabby-dev-vpc
      Mappings: select 2 subnets: gabby-dev-pub-subnet-1a/1b
    Security groups: select gabby-dev-pub-ec2-sg
    Listeners and routing:
      Protocol:http
      port: 80
      select a target group: 
        gabby-dev-foo
        gabby-dev-bar
    Review summary once again >> CREATE LOAD BALENCER 

    Load balancers >> gabby-dev-foo-bar-alb >> listeners & rules >>
    HTTP:80 listener >> add rule >>
      Name: foo_rule
            bar_rule >> next 
    add condtion:
     choose condition: path
       Path: 
       /foo
       /bar >> confirm >> next
       Routing actions:
         Forward to target groups:
           Target group: 
           select:
             gabby-dev-foo
             gabby-dev-bar >>next 
             Priority:
              1
              2 >> next >> create

*** select load balancer >> details >> on web:
copy : 
DNS name: gabby-dev-foo-bar-alb-894256668.ap-south-1.elb.amazonaws.com - private ip
DNS name: gabby-dev-foo-bar-alb-894256668.ap-south-1.elb.amazonaws.com/foo - shows foo instance details
DNS name: gabby-dev-foo-bar-alb-894256668.ap-south-1.elb.amazonaws.com/bar - shows bar instance details

```


