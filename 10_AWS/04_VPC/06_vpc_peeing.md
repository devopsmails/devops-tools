What is VPC PEERING?

```
VPC peering is a way to securely connect virtual private clouds (VPCs) within the same AWS account, or even between accounts and regions. 
It creates a networking connection that allows resources in each VPC to communicate with each other using private IP addresses, just like they were on the same network.
```

Benefits of VPC PEERING?
```
Simplified Network Communication
Cost-effective
Reduced Latency
Enhanced Security
Simplified Management
```

1.CREATE 2 VPCS
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc-1
  cidr: 10.0.0.0/16 >> Create VPC = 65256
  Tenancy: Default

AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc-2
  cidr: 11.0.0.0/16 >> Create VPC = 65256
  Tenancy: Default

2. Internet gateway creation for vpc1(pub subnet)
=======================
vpc >> igw create >> name: gabby-dev-vpc-1-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-vpc-1-igw >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc-1 >> Attach internet gateway

    Internet gateway creation for vpc2(pub subnet)
=======================
vpc >> igw create >> name: gabby-dev-vpc-2-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-vpc-2-igw >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc-2 >> Attach internet gateway

3.Create 1 pub subnet for vpc-1
===============================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-1
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-pub-sub-1-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet

    Create 1 private subnet for vpc-2
    ===============================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-2
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-private-sub-2-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 11.0.1.0/24 >> add new subnet

4.Route Table Creation for vpc1(pub subnet)
=====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-sub-vpc1-rt
    VPC: gabby-dev-vpc-1 id >> create route table
      Subnets association>>edit subnet associations >>
        select public subnet id >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pubsubnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-vpc-1-igw >> save changes

    Create Route Table for vpc2(pub subnet)
    =====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-sub-vpc2-rt
    VPC: gabby-dev-vpc-2 id >> create route table

    Subnets association>>edit subnet associations >>
        select public subnet vpc2 id >> Save association
    
     Route table associate with IGW(route table should have internet access)
    =============================
  select route gabby-dev-pubsubnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-vpc-2-igw >> save changes

5.Create 2 instances on 2 vpcs
=======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-pub-ec2-vpc-1 & gabby-dev-pub-ec2-vpc-2
  Ubuntu: freetier
  Instance type : t2.micro
  Key pair: aws-login
  Network settings >>
    vpc: gabby-dev-vpc-1 & gabby-dev-vpc-2
    subnet: gabby-dev-pub-sub-1-1a & gabby-dev-pub-sub-2-1a
    Auto-assign public IP: Enable
    security group name: gabby-dev-ssh-http-sg
      description: gabby-dev-ssh-http-sg
    Inbound Security Group Rules:
      ssh: http
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

****Take public ip of each ec2 instance & search on web it provides the details of ip address

6. Create VPC PEERING:
=====================
AWS >> VPC >>PEERING CONNECTIONS >>Peering connection settings
    NAME: gabby-dev-vpc-peering-with-vpc1-vpc2
    Select a local VPC to peer with(requester): select vpc-1 id
    Select another VPC to peer with(accepter): select vpc-2-id 
    >> create vpc peering connection >>
    *** Should accept the perring connection ***
    Actions: Accept request >> Review requester & accepter details >> Accept request >>

7.Modify both route tables to access accessed by each other
=======================================
aws >> vpc >> route table >> gabby-dev-pub-sub-vpc1-rt >> edit routes >>
    copy vpc2 cidr range: 11.0.0.0/16 from vpc2
    Destination: 11.0.0.0/16 
    Target: Peering connect >> select peering id(gabby-dev-vpc-peering-with-vpc1-vpc2) >> Save the changes

aws >> vpc >> route table >> gabby-dev-pub-sub-vpc2-rt >> edit routes >>
    copy vpc2 cidr range: 10.0.0.0/16 from vpc1
    Destination: 10.0.0.0/16 
    Target: Peering connect >> select peering id(gabby-dev-vpc-peering-with-vpc1-vpc2) >> Save the changes


8.ssh into both ec2
=========================
aws >> instance id >> connect >> 
  go to cmd prompt >> cd aws_login.pem dir
    ssh -i "aws_login.pem" ubuntu@public_ip>>
      ask for confirmation : yes
      We can view public subnet range ip
    
*** after ssh into each ec2
*** curl ec2 -2 private ip from ec2 1
    curl 11.0.1.129(pri ip)
*** curl ec2 -1 private ip from ec2 2
    curl 10.0.0.44(pri ip)

*** You can see connection is established between 2 vpc using peering

*** Remove VPC PEERING ESTBLISHMENT IN ROUTE TABLE BY REMOVING EACH TARGET RANGE OF OTHER VPC & CHECK same curl command will not work
