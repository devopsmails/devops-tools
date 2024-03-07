What is Bastion Host or Jump Server?  
```
A bastion server, also known as a jump server or jump box

A bastion server is a special-purpose server designed to provide secure access to a private network from an external network like the internet. 

Bastion server typically resides in a public subnet within a VPC

It has a public IP address that allows users to connect to it from the internet. 

Security groups are configured on the bastion host to restrict inbound traffic, often only allowing SSH or RDP connections from specific IP addresses or ranges. 

Once connected to the bastion server, users can then establish secure connections (using SSH tunnels or RDP) to access resources within the private subnets of the VPC.
```
Bastion Image
Bastion Host setup?  
  
```
1.VPC CRATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC

2. Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

3.Create Public & private subnets
===============================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pubsubnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
    sunet2 >> 
      Subnet name: gabby-dev-privatesubnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> create sub

4.Route Table Creation
=====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pubsubnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select public subnet id >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pubsubnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes

5.Create Private route table with Private subnet association without internet access
==================================================================================
vpc >> route tables >> Route table settings
    Name: gabby-dev-private-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>> edit subnet associations >>
        select private subnet id >> Save association
      **no route IGW as it's private not allwing direct intenet access
      ** only it can access through VPC range internally

6.Create Bastion instance on public subnet
=======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-pub-bastian-ec2
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: aws-login
  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-pub-subnet-1a
    Auto-assign public IP: Enable
    security group name: gabby-dev-pub-bastian-ec2-sg
      description: gabby-dev-pub-bastian-ec2-sg
    Inbound Security Group Rules:
      ssh: 
  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

7.Create Private ec2 instance in Private subnet with only pub-ec2-range
===================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-private-ec2
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: aws-login
  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-private-subnet-1b
    Auto-assign public IP: disabl
    security group name: gabby-dev-private-ec2-sg
      description: gabby-dev-private-ec2-sg
    Inbound Security Group Rules:
      ssh: with custom range 10.0.1.0/24(public subnet ip range)

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

8.ssh into bastion pub ec2
=========================
aws >> instance id >> connect >> 
  go to cmd prompt >> cd aws_login.pem dir
    ssh -i "aws_login.pem" ubuntu@public_ip>>
      ask for confirmation : yes
      We can view public subnet range ip
  
9.ssh into private server from bastion pub instance
============================================
Once we ssh into bastion server. 
*COPY THE PRIVATE SERVER .PEM FILE KEY INTO public server in a file
** vi aws_login.pem
copy paste the private key
chmod 400 aws_ login.pem

ssh -i "aws_login.pem" ubuntu@privateip
**will be able ssh private server through only bastian or public server





