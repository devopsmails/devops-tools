https://i.imgur.com/PZQcHpI.png

WHAT IS VPC END POINTS?
=======================
```
VPC endpoints are virtual devices that act as a secure and efficient way to connect your resources in a Virtual Private Cloud (VPC) to specific AWS services. 
They essentially create a private connection within the AWS network, eliminating the need for your data to travel over the public internet. 
```
VPC END POINTS BENEFITS
======================
```
Enhanced Security
Improved Performance
Simplified Network Management
```

VPC END POINT SETUP
===================
```
1.VPC CRATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC

2.CREATE 2 PUBLIC SUBNETS & 2 PRIVATE SUBNET IN SAME VPC AZ 1A & 1B
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
sub-net4: 
      Subnet name: gabby-dev-private-subnet-1b
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.4.0/24 >> create subnets

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
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-pub-subnet-1a
    Auto-assign public IP: Enable
    create security group name: gabby-dev-pub-ec2-sg
      description: gabby-dev-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

Create 1 ec2 instance in private subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-private-ec2-1a
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-private-subnet-1a
    Auto-assign public IP: Disable ****
    create security group name: gabby-dev-private-ec2-sg
      description: gabby-dev-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

SSH INTO PULIC EC2 INSTANCE
==========================
chmod 400 gabb-dev-login.pem 
ssh -i gabb-dev-login.pem ec2-user@PUB-PRIVATE-IP

 Once ssh into pub ec2 >> ssh into private ec2 from public
 =========================================================
 vi gabb-dev-login.pem copy & paste private key & save the file.
 chmod 400 gabb-dev-login.pem 
 ssh -i gabb-dev-login.pem ec2-user@PUB-PRIVATE-IP 

6.Try creating s3 buckets & list s3 buckets from Private ec2 instance by configuring aws creds
===================================
aws s3 ls   - No results will be shown as it's trying to list s3 buckets is from """Private ec2 instance which in private vpc""""

***** TO ACCESS ANY OTHER AWS SERVICES FROM PRIVATE VPC INSTANCE NEED TO CREATE VPC ENDPOINT

7. CREATE VPC END POINT
======================
AWS >> VPC >> END POINTS >> CREATE END POINTS :
Endpoint settings:
  name: gabby-dev-vpc-endpoint
  Service category: aws services
  Services: search s3
    select: type: gateway s3
    VPC: Selecr gabby-dev-vpc
    Route tables:
     selecr: gabby-dev-private-rt
    Policy: full access >> create end point

***** Try: again listing aws s3 buckets from private instance
aws s3 ls


