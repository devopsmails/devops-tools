What is Weighted Routing?
====================
```
Weighted routing is a technique used to distribute traffic among multiple resources associated with a single domain name or subdomain. 
It basically allows you to control the flow of users to different destinations.
We can distribute trafic percentage wise
ex: 
256 = 100%
128 = 50%
128 = 50%

```

weighted Routing image:
```
                                                     ===============aws============
                                                     >> route53 ns >> A record >> Load balencers1(50%) >> ec2s
USER >> www.sridharmaya.com >>godaddy or freedomaini 
                                                     >> route53 ns >> A record >> Load balencers2(50%) >> ec2s
                                                     ===============aws============
```

LOAD BALANCERS-1 SETUP
==================
```
aws >> vpc >> pub & pri sub net >> igw >> route table >> pub & pub ec2
```
LOAD BALANCER SETUP WITH VPC ONLY:
=============================
```
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65536

2.CREATE 2 PUBLIC SUBNETS IN DIFFENT AZS & 1 PRIVATE SUBNET 1A AZ IN SAME VPC
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
subnet2 >> 
      Subnet name: gabby-dev-pub-subnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> add new subnet
sub-net3: 
      Subnet name: gabby-dev-private-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.3.0/24 >> create subnets

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
    Name: gabby-dev-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-subnet-rt id >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes
 
  Create Private route table with Private subnet association without internet access
==================================================================================
vpc >> route tables >> Route table settings
    Name: gabby-dev-private-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>> edit subnet associations >>
        select private subnet id >> Save association

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

6.CREATE TARGET GROUPS(instances will be attached)
=====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name:  
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


LOAD BALANCERS-2 SETUP
==================
```
aws >> vpc >> pub & pri sub net >> igw >> route table >> pub & pub ec2
```
LOAD BALANCER SETUP WITH VPC ONLY:
=============================
```
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc-2
  cidr: 11.0.0.0/16 >> Create VPC = 65536

2.CREATE 2 PUBLIC SUBNETS IN DIFFENT AZS & 1 PRIVATE SUBNET 1A AZ IN SAME VPC
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1a-vpc2
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 11.0.1.0/24 >> add new subnet
subnet2 >> 
      Subnet name: gabby-dev-pub-subnet-1b-vpc2
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 11.0.2.0/24 >> add new subnet
sub-net3: 
      Subnet name: gabby-dev-private-subnet-1a-vpc2
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 11.0.3.0/24 >> create subnets

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw-2 >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

4. Route Table Creation
=====================
Public Route Table creation:
==========================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-subnet-rt-vpc-2
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-subnet-rtvpc-2 id >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw-2 >> save changes
 
  Create Private route table with Private subnet association without internet access
==================================================================================
vpc >> route tables >> Route table settings
    Name: gabby-dev-private-rt-vpc-2
    VPC: gabby-dev-vpc2-id >> create route table
      Subnets association>> edit subnet associations >>
        select private subnet id >> Save association

5. Create 1 ec2 instance in public subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-pub-ec2-1a-vpc-2
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc-2
    subnet: gabby-dev-pub-subnet-1a-vpc2
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
    Target group name:  
    Protocol : Port: http: 80
    IP address type: Ipv4
    VPC: select: gabby-dev-vpc2
    Protocol version: HTTP1
    Health checks:
      Health check protocol: http
      Health check path: / = root (on which path it should check the health stauts ex: 10.0.1.125:8080/home)
    Advanced health check settings: default 
      >> next >>
        Register targets:
          Available instances: select: gabby-dev-pub-ec2-1a-vpc-2 >>
          include as pending below >> Create target group >>

7.APPLICATION LOAD BALANCER CREATION
=====================================
AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
Compare and select load balancer type: Application Load Balancer >> Create
Create Application Load Balancer >>Basic configuration >>
  Load balancer name: gabby-dev-alb-vpc-2
  Scheme: Internet facing
  IP address type: IPv4
  Network mapping:
    VPC: select gabby-dev-vpc-2
    Mappings: select 2 subnets: gabby-dev-pub-subnet-1a-vpc2/1b
    Create a sg: gabby-dev-pub-ec2-sg
    ssh : anywhere ipv4 
    http : anywhere ipv4 >> Create sg  < or >
  Security groups: select gabby-dev-pub-ec2-sg
  Listeners and routing:
    Protocol:http
    port: 80
    select a target group: gabby-dev-alb-tg-vpc2
  Review summary once again >> CREATE LOAD BALENCER 
  ***go to load balancer >> Wait for some time to complete provisioning & to become active
  *** select load balancer >> details >> copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com 
```
8.CREATE A-RECORD USING AWS ROUTE-53 Weighted Routing & ATTCHED WITH 2 LOAD BALANCER
=========================================================
```
AWS >> Route 53 >> Hosted zones >>  sridharmaya.com >> Create record >>
Quick create record:
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-294273890.ap-south-1.elb.amazonaws.com/

    Routing policy: Weighted
        Weight:128(50%)>> add another Record  >>
    
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-vpc2-294273890.ap-south-1.elb.amazonaws.com/

    Routing policy: Weighted
        Weight:128(50%) >> Create Record >> Show status >>
**** Once the status is """INSYNC""" Copy the DNS name(sridharmaya.com) on browser & we can see it shows the private ip of the ec2 instance.
```
