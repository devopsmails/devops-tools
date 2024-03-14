WHAT IS TRANSIT GATE WAYS IN VPC?

```
An AWS Transit Gateway is a fully managed service that allows you to connect VPCs and on-premises networks together in a hub-and-spoke model. 
It acts as a central hub for routing traffic between these interconnected networks.
```
WHY SHOULD USE TRANSIT GATE WAYS?
```
Less VPC Peering Chaos
Scales Like a Boss
Security on Lock
See the Big Picture: Gain central visibility into network traffic by sending Transit Gateway flow logs to CloudWatch Logs and S3. This lets you monitor performance and troubleshoot issues efficiently.
```
DIFF B/W VPC PEERING & TRANSIT GATEWAYS:
```
vpc peering:
    
    Only 2 vpc will be attached with vpc peering
    Not possible to attach more than 2 for one vpc peering
    Diffcult to manage if vpc are more than 3 or 5
    Ex: Each 2 vpc attch with 1 vpc peering
    

Transit Gateway:
    Easy to attach any number of VPCs to Transit gateway where they all can communicate with each other
    ex: 1 Transit Gateway attach with any of VPCs
```
```
1.CREATE 3 VPCS(PUBLIC ACCESS):
AWS >> VPC >> Create VPC>> vpc only:
  VPC name: 
    gabby-dev-vpc-1
    gabby-dev-vpc-2
    gabby-dev-vpc-3
  cidr: 
    10.0.0.0/16
    11.0.0.0/16
    12.0.0.0/16 >> Create VPC

2. CREATE 3 Internet gateways for 3 vpcs
=======================
vpc >> igw create >> name: 
    gabby-dev-igw1
    gabby-dev-igw2
    gabby-dev-igw3 >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-igw1,2,3 id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: 
            gabby-dev-vpc-1
            gabby-dev-vpc-2
            gabby-dev-vpc-3 >> Attach internet gateway

3.CREATE 3 PUBLIC SUBNETS one for each vpc
=================================================
vpc >> subnets >> create subnets >> 
  vpc's: 
    gabby-dev-vpc-1
    gabby-dev-vpc-2
    gabby-dev-vpc-3
  subnet settings >> 
    subnet1 >> 
      Subnet name: 
        gabby-dev-pub-subnet-1-1a
        gabby-dev-pub-subnet-2-1a
        gabby-dev-pub-subnet-3-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 
        10.0.1.0/24
        11.0.1.0/24
        12.0.1.0/24 >> add new subnet

4.Create 3 Route Tables for each vpc & subnet
=====================
vpc >> route tables >> create route table >> Route table settings
    Name: 
        gabby-dev-pub-sub1-rt-1
        gabby-dev-pub-sub2-rt-2
        gabby-dev-pub-sub3-rt-3
    VPC:
        gabby-dev-vpc-1
        gabby-dev-vpc-2
        gabby-dev-vpc-3  >> create route table
      Subnets association>>edit subnet associations >>
        select:
            gabby-dev-pub-subnet-1-1a
            gabby-dev-pub-subnet-2-1a
            gabby-dev-pub-subnet-3-1a >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route >>
    gabby-dev-pub-sub1-rt-1
    gabby-dev-pub-sub2-rt-2
    gabby-dev-pub-sub3-rt-3 >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess internet)
    Target: igw >> 
            gabby-dev-igw1
            gabby-dev-igw2
            gabby-dev-igw3    >> save changes

5.Create 3 ec2 instances for 3 vpc with subnets created in that vpcs
========================================
AWS >> EC2 >> Launch an instance :
  Name: 
    gabby-dev-pub-ec2-vpc1-1a
    gabby-dev-pub-ec2-vpc2-1a
    gabby-dev-pub-ec2-vpc3-1a

  Ubuntu: 22.04 freetier
  Instance type : t2.micro
  Key pair: create kay pair >> 
    gabby-dev-key-pair

  Network settings >>
    vpc: 
        gabby-dev-vpc-1
        gabby-dev-vpc-2
        gabby-dev-vpc-3
    subnet: 
        gabby-dev-pub-subnet-1-1a
        gabby-dev-pub-subnet-2-1a
        gabby-dev-pub-subnet-3-1a
    Auto-assign public IP: Enable
    create security group name: 
        gabby-dev-pub-ec2-ssh-http-sg-1
        gabby-dev-pub-ec2-ssh-http-sg-2
        gabby-dev-pub-ec2-ssh-http-sg-3
      description: gabby-dev-pub-ec2-sg-ssh-http
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

6.Create Tranist gate for all the 3 vpcs
=========================================
aws >> vpc >> transit gate ways:
    name:
        gabby-dev-tgw-vpc1-2-3
    Description: tgw for vpc 1, 2, 3
    Configure the transit gateway:
        Amazon side Autonomous System Number (ASN): empty
        check all: 
            DNS support
            VPN ECMP support
            Default route table association
            Default route table propagation
    Configure cross-account sharing options: Empty
    Transit gateway CIDR blocks: empty >> Create Transit Gateway

7.Transit Gateway Attachment with vpc1,2,3(TGA=tgw+vpc1,2,3)
===========================
AWS >> VPC >> Transit Gateway Attachment >> create Transit Gateway Attachment:
    name: 
        gabby-dev-tga-vpc-1
        gabby-dev-tga-vpc-2
        gabby-dev-tga-vpc-3
    Transit gateway ID: select: gabby-dev-tgw-vpc1-2-3
    Attachment type: vpc (VPN - For On prem servers)
    VPC attachment:
        check: DNS support
        VPC ID: select:
            gabby-dev-vpc-1
            gabby-dev-vpc-2
            gabby-dev-vpc-3 
        Subnet IDs: ap-south-1a (if multi subnets were create under each vpc should
                     check all subnets)
        >> Create Transit Gateway Attachments >>

8. Allowing other 2 vpcs cidr range in 3 Route Tables Route 
=================================
aws >> vpc >> Route tables >> 
    select id:
        gabby-dev-pub-sub1-rt-1
        gabby-dev-pub-sub2-rt-2
        gabby-dev-pub-sub3-rt-3 >> 
            route >> edit routes >>
            Destination: 
            11.0.0.0/16 & 12.0.0.0/16
            10.0.0.0/16 & 12.0.0.0/16
            10.0.0.0/16 & 11.0.0.0/16
            Target: Tansit Gateway >> Select Transit Gateway Attachment:
                gabby-dev-tga-vpc-1
                gabby-dev-tga-vpc-2
                gabby-dev-tga-vpc-3 >> Save Changes

9.ssh into 3 ec2
=========================
aws >> instance id >> connect >> 
  go to cmd prompt >> cd aws_login.pem dir
    ssh -i "aws_login.pem" ubuntu@public_ip>>
      ask for confirmation : yes
**** curl ec2-2 & 3 private ip to check whether will be able to access from vpc1 
**** curl ec2-1 & 3 private ip to check whether will be able to access from vpc2 
**** curl ec2-1 & 2 private ip to check whether will be able to access from vpc3 
You can view the successful communication
```