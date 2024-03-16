WHAT IS NAT GATEWAY?

```
A NAT gateway is a managed Network Address Translation (NAT) service offered by Amazon Virtual Private Cloud (VPC). 
It acts as an intermediary for outbound traffic originating from instances in private subnets within your VPC.

Instances in private subnets are assigned private IP addresses that are not routable on the public internet.
When an instance in a private subnet initiates a connection to the internet (e.g., to download updates, access external APIs), the traffic is routed to the NAT gateway.
The NAT gateway translates the private IP address of the instance to its own public IP address (Elastic IP) before sending the traffic out to the internet.
The internet receives the traffic as if it originated from the NAT gateway, not the individual instance.
When the response from the internet arrives, the NAT gateway translates it back to the private IP address of the originating instance and forwards it to the instance.
```
BENEFITS OF NAT GATEWAY?

```
Enhanced Security: 
    NAT gateways provide a layer of security by keeping private IP addresses of your instances hidden from the public internet. This makes it more difficult for attackers to directly target your instances.
Cost Optimization: 
    You can control outbound internet access by using a single NAT gateway for multiple instances, potentially reducing costs associated with public IP addresses.
Isolation:
Simplified Instance Management: 

```
NAT Gate way setup
====================
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65256

2.Create Public & private subnets
===============================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
    sunet2 >> 
      Subnet name: gabby-dev-private-subnet-1b
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.2.0/24 >> create sub

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc >> Attach internet gateway

4.Route Table Creation
=====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select public subnet id >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pub-rt id>> route >>
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

6.CREATE NAT GATE WAY(ON PUBLIC SUBNET, PRIVATE SUBNET CAN ACCESSES THE INTERNET USING NAT GATEWAY, AS IGW IS ATTACHED TO PUB SUBNET)
======================================
AWS >> VPC >> NAT GATEWAY >> CREATE NAT GATEWAY:
    name: gabby-dev-natgw
    subnet: select pub sub id (gabby-dev-pub-subnet-1a) as private subnet wants 
        access the internet
    Connectivity type: Select public(To access the Internet access)    
        (***Private=Can't access internet, Only it can access internet other vpc with in the same aws account)  
    Elastic IP allocation ID: 
    >> Allocate Elastic ip >> Select the allocated elastic ip 
    >> Create Nat gateway >>
*** Refresh till the nat gateway is active

7.Update the private Route table
==============================
aws >> vpc >Route Table >> Private Route id:gabby-dev-private-rt
    routes >> edit routes :
        Desstination: 0.0.0.0/0(for internet access)
        target : NAT Gateway >> Select Nat Gateway id: gabby-dev-natgw 
        >> Save Changes 

8.Creatinig Ec2 Instance on Public Subnet & Private subnet:
=====================================
AWS >> EC2 >> Launch an instance :
  Name: 
  gabby-dev-pub-ec2
  gabby-dev-private-ec2
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair:  Create keypair: 
    gabby-dev-pub-ec2-key 
    gabby-dev-private-ec2-key

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-private-subnet-1a
    Auto-assign public IP: 
        Enable
        Disable
    security group name: create: gabby-dev-ssh-hhtp-sg
      description: 
    Inbound Security Group Rules:
      ssh: 
      http
  Configure storage: 8 GB
  Number of instances: 1 >> Create instance
    Advanced settings:
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

9.SSH into pub ec2:
=============
terminal :
    chmod 400 gabby-dev-pub-ec2-key.pem
    ssh -i "gabby-dev-pub-ec2-key.pem" ubuntu@13.232.255.231

    SSH into private ec2 from pub EC2:
    *** Copy paste the Private key pair private key 
    vi gabby-dev-private-ec2-key.pem
    ***paste the public key & save it
    chmod 400 gabby-dev-private-ec2-key
    ssh -i "gabby-dev-pub-ec2-key.pem" ubuntu@10.0.2.216
    *** ping www.google.com
    *** packages will be sent & received with out any miss.

*** Try: 
    ===
        Remove nat gateway from Private route table >> route
        ping www.google.com(Now it'll not work)

```
