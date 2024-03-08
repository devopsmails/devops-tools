What is Load Balancing?  
---- 
image:
```
Load balancing is a technique that distributes incoming traffic across multiple servers.  
This helps to improve the performance and reliability of a web application or other online service.  
```
Type1: LOAD BALANCER SETUP WITH VPC ONLY:
=============================
```
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65536

2. Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

3.CREATE 2 PUBLIC SUBNETES IN DIFF AVAILABLITY ZONES
=================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
    sunet2 >> 
      Subnet name: gabby-dev-pub-subnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> create subnets

4.Route Table Creation
=====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-subnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes

5.Create 2 ec2 instances on public subnet 1a & 1b
=======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-pub-ec2-1a/1b
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-pub-subnet-1a/1b
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

6.CREATE TARGET GROUPS(instances will be attached)
=====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name: gabby-dev-alb-tg
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
          Available instances: select: gabby-dev-pub-ec2-1a,gabby-dev-pub-ec2-1b >>
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
  Security groups: select gabby-dev-pub-ec2-sg
  Listeners and routing:
    Protocol:http
    port: 8080
    select a target group: gabby-dev-alb-tg
  Review summary once again >> CREATE LOAD BALENCER 
  ***go to load balancer >> Wait for some time to complete provisioning & to become active
  *** select load balancer >> details >> copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com 
  *** >> paste on browser new tab search>> """"refresh to view the changing traffic one instance to another  """

  


















```

type2: Load Balancer Setup vpc & more?  
-------------------
```
EC2 Dash Board >> Load Balancers >> Create Load Balancers:  
Application Load Balancer >> Create >>
Create Application Load Balancer
--------
  * Basic configuration:
    >Load balancer name: #gabby-prod-vpc
    >check: Intenet facing
  * IP address type: IPV4
  * Network mapping:
      >vpc: #gabby-prod-vpc
      >Mappings:(***must be on public subnets***)
        > check: us-east-1a (use1-az2)
        > Check: us-east-1b (use1-az4)
   * Security groups: gabby-prod-vpc
   * Listeners and routing:
      > click: Create target group >>:
        > Choose a target type: Instance
        > Target group name: gabby-prod-vpc
        > Protocol: http
        > VPC: gabby-prod-vpc
        > Health check protocol: HTTP
        >>Next>>
        ** Register targets**
          >  Available instances: Check: The instance for load balancing
          > Ports for the selected instances: #8000
          > click: Include as pending below (It stops the traffic immediate routing to these instances)
          > Targets:
              >> click: Create Target Groups >> Target groups will be created & will be available for selecting the targets at main load balencer page
   * Refresh on the Target groups:
      > select the target group created
      >> Click:   Create Load Balencer >>
          >> View Load Balancer >>
             Take the Load balancer DNS name & check it on the intenet. it will work if not make sure 8000, 80, 22 ports are enabled at SG 
```