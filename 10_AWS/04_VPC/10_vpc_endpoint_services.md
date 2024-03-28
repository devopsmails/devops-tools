

******** This helps connect """ON-PREM""" PRIVATE SERVERS WITH AWS """PRIVATE SERVIERS""" INTERNALLY WITHOUT GOING THROUGH INTERNET FOR BETTER SECURITY

WHAT IS IS THE VPC END POINT SEVICES?
==================================
```
VPC Endpoint Services, powered by AWS PrivateLink, let you securely share your own AWS services hosted within a VPC with authorized VPCs in your account or even other AWS accounts. 
It essentially creates a private connection for these services, eliminating the need for them to be exposed to the public internet.
```
BENEFITS:
=========
```
Enhanced Security
Granular Access Control
Simplified Service Discovery
```
DIFF B/W VPC END POINT & VPC END POINT SERVICES?
============================================
```
The key difference between VPC Endpoints and VPC Endpoint Services (powered by AWS PrivateLink) lies in their purpose and who manages the connected service:

VPC Endpoints:

Purpose: 
    Connect your VPC resources to supported AWS services offered by Amazon (like S3, DynamoDB, etc.).
Connectivity: 
    Establish a private connection between your VPC and a specific AWS service.
Service Access: 
    You directly access pre-existing AWS services through the endpoint.
Control: 
    AWS manages the service you're connecting to.
Benefits:
    Enhanced security by keeping traffic within AWS.
    Reduced data transfer costs for intra-region traffic.
    Simplified outbound firewall rules.

VPC Endpoint Services (PrivateLink):

Purpose: 
    Share your own private AWS services hosted within a VPC with authorized VPCs.
Connectivity: 
    Create a private connection for your custom service to be accessed by authorized VPCs.
Service Access: 
    You share your own service (e.g., S3 bucket, DynamoDB table) through the endpoint.
Control: 
    You manage the service being exposed, controlling access with VPC endpoint policies.
Benefits:
    Securely share your services with specific VPCs.
    Granular control over access.
    Simplified service discovery for consumers.
```
PROVIDER VPC SETUP
================
```
1.VPC CRATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc-provider
  cidr: 10.0.0.0/16 >> Create VPC

2.CREATE 2 PUBLIC SUBNETS & 2 PRIVATE SUBNET IN SAME VPC AZ 1A & 1B
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-provider-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.1.0/24 >> add new subnet
subnet2 >> 
      Subnet name: gabby-dev-provider-pub-subnet-1b
      Availability Zone: ap-south-1b
      IPv4 VPC CIDR block: 10.0.2.0/24 >> add new subnet
sub-net3: 
      Subnet name: gabby-dev-provider-private-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.3.0/24 >> create subnets
sub-net4: 
      Subnet name: gabby-dev-provider-private-subnet-1b
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 10.0.4.0/24 >> create subnets

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-provider-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-pc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc-provider >> Attach internet gateway

4. Route Table Creation
=====================
Public Route Table creation:
==========================
vpc >> route tables >> Route table settings
    Name: gabby-dev-provider-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-provider-pub-subnet-rt id >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes
 
  Create Private route table with Private subnet association without internet access
==================================================================================
vpc >> route tables >> Route table settings
    Name: gabby-dev-provider-private-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>> edit subnet associations >>
        select private subnet id >> Save association

5. Create 1 ec2 instance in public subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-provider-pub-ec2-1a
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-provider-pub-subnet-1a
    Auto-assign public IP: Enable
    create security group name: gabby-dev-pub-ec2-sg
      description: gabby-dev-provider-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

Create 1 ec2 instance in private subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-provider-private-ec2-1a
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-provider-private-subnet-1a
    Auto-assign public IP: Disable ****
    create security group name: gabby-dev-private-ec2-sg
      description: gabby-dev-provider-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 & 80: ANYWHERE IPV4

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

SSH INTO PULIC EC2 INSTANCE
==========================
chmod 400 gabb-dev-login.pem 
ssh -i gabb-dev-login.pem ec2-user@provider-pub-ipv4
*** ping google.com             - IT CONNECTS WITH GOOGLE.COM AS IT'S EXPOSED TO INTERNET ACCESS

 Once ssh into pub ec2 >> ssh into private ec2 from private
 =========================================================
 vi gabb-dev-login.pem copy & paste private key & save the file.
 chmod 400 gabb-dev-login.pem 
 ssh -i gabb-dev-login.pem ec2-user@provider-private-ipv4
*** ping google.com             - IT CAN'T CONNECT WITH GOOGLE.COM AS IT IS RESTRICTED INTERNET ACCESS

6.CREATE NAT GATE WAY(ON PUBLIC SUBNET(IGW CONNECTED), PRIVATE SUBNET CAN ACCESSES THE INTERNET USING NAT GATEWAY, AS IGW IS ATTACHED TO PUB SUBNET)
======================================
AWS >> VPC >> NAT GATEWAY >> CREATE NAT GATEWAY:
    name: gabby-dev-provider-natgw
    subnet: select pub sub id (gabby-dev-provider-pub-subnet-1a) as private subnet wants 
        access the internet
    Connectivity type: Select public(To access the Internet access)    
        (***Private=Can't access internet, Only it can access internet other vpc with in the same aws account)  
    Elastic IP allocation ID: 
    >> Allocate Elastic ip >> Select the allocated elastic ip 
    >> Create Nat gateway >>
*** Refresh till the nat gateway is active

7.Update the private Route table
==============================
aws >> vpc >Route Table >> Private Route id:gabby-dev-provider-private-rt
    routes >> edit routes :
        Desstination: 0.0.0.0/0(for internet access)
        target : NAT Gateway >> Select Nat Gateway id: gabby-provider-dev-natgw 
        >> Save Changes 

pub ec2 >> ssh into private ec2 from private
======================================
*** ping google.com             - IT CAN CONNECTs NOW WITH GOOGLE.COM AS IT IS ENABLED WITH """NATGATEWAY""" WHICH ALLOWS INTERNET ACCESS

*** sudo dnf install httpd -y   - it installs httpd package to nat enbled private instance

sudo systemctl status httpd         - will be inactive
sudo vi /var/www/html/index.html    
--------------------
<!DOCTYPE html>
<html>
<body>

<h1>This is the demo from vpc end point services: from provider private ec2</h1>

</body>
</html>
-------------------
sudo  systemctl restart httpd       - active & running
curl localhost                      - shows web page locally as it doesn't have internet access

DELETE NAT GATEWAY TO ISOLOATE & RESTRICT INTERNECT ACCESS
==================================
AWS >> VPC >> NAT GATEWAY >> Select: NAT GATEWAY >> delete

**** Refresh until status is deleted

DELETE THE ELASTIC IP:
====================
AWS >> VPC >> Select the elastic IP >> Actions >> Release Elastic ip address >> Release

private ec2 :
==========
ping google.com             - Now it cannot reach internet

8.CREATE TARGET GROUPS(not for http BUT for TCL)
=====================
aws >> ec2 >> Load balancing >> target groups >> Create target group:
  Specify group details:
    Choose a target type: Instances
    Target group name: gabby-dev-provider-nlb-tg
    Protocol : Port: "" TCP"": 80 **** as we want set up Network load balancer
    IP address type: Ipv4
    VPC: select: gabby-dev-provider-vpc
    Protocol version: HTTP1
    Health checks:
      Health check protocol: http
      Health check path: / = root (on which path it should check the health stauts ex: 10.0.1.125:8080/home)
    Advanced health check settings: default 
      >> next >>
        Register targets:
          Available instances: select: gabby-dev-provider-private-ec2-1a >>
          include as pending below >> Create target group >>

9.Network load balancer setup
=============================
  AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
  Compare and select load balancer type: *** Network Load Balancer *** >> Create
  Create Application Load Balancer >>Basic configuration >>
    Load balancer name: gabby-dev-provider-nlb
    Scheme: Internal
    IP address type: IPv4
    Network mapping:
      VPC: select gabby-dev-provider-vpc
      Mappings: select only 2 subnets: gabby-dev-provder-priavte-subnet-1a/1b
    Security groups: select gabby-dev-provider-private-ec2-sg
    Listeners and routing:
      Protocol: http ***
      port: 80
      select a target group: gabby-dev-provider-alb-tg
    Review summary once again >> CREATE LOAD BALENCER 

    ***go to load balancer >> REFRESH & Wait for some time to complete provisioning & to become active

10. AWS PRIVATE LINK
====================
aws >> vpc >> endpoint services >> Create endpoint services >>
  name: gabby-dev-provider-endpoint-service
  Load balancer type: Network **** as we are using network loadbalancer. 
  Available load balancers: gabby-dev-provider-nlb
  Additional settings:
  check: Acceptance Required
  Supported IP address types:
    ipv4 >> create >> endpoints >> status: active 

```

CONSUMER VPC SETUP
==================
1.VPC CRATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-consumer-vpc
  cidr: 20.0.0.0/16 >> Create VPC

2.CREATE 2 PUBLIC SUBNETS & 2 PRIVATE SUBNET IN SAME VPC AZ 1A & 1B
===========================================================================
vpc >> subnets >> create subnets >> 
  vpc's: gabby-dev-consumer-vpc-id
  sunet settings >> 
    sunet1 >> 
      Subnet name: gabby-dev-consumer-pub-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 20.0.1.0/24 >> add new subnet
sub-net 2: 
      Subnet name: gabby-dev-consumer-private-subnet-1a
      Availability Zone: ap-south-1a
      IPv4 VPC CIDR block: 20.0.3.0/24 >> create subnets

3.Internet gateway creation
=======================
vpc >> igw create >> name: gabby-dev-consumer-igw >> Create IGW

  Attach IGW with VPC
  ===================
  VPC >> igw >> gabby-dev-vpc id >> Actions >> Attach vpc >> Avail vpcs : 
        Select: gabby-dev-vpc-consumer >> Attach internet gateway

4. Route Table Creation
=====================
Public Route Table creation:
==========================
vpc >> route tables >> Route table settings
    Name: gabby-dev-consumer-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select both public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-consumer-pub-subnet-rt id >> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-consumer-igw >> save changes
 
  Create Private route table with Private subnet association without internet access
==================================================================================
vpc >> route tables >> Route table settings
    Name: gabby-dev-consumer-private-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>> edit subnet associations >>
        select private consumer subnet id >> Save association

5. Create 1 ec2 instance in public subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-consumer-pub-ec2-1a
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-consumer-lb-key-pair

  Network settings >>
    vpc: gabby-dev-consumer-vpc
    subnet: gabby-dev-consumer-pub-subnet-1a
    Auto-assign public IP: Enable
    create security group name: gabby-dev-consumer-pub-ec2-sg
      description: gabby-dev-consumer-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

Create 1 ec2 instance in private subnet
======================================
AWS >> EC2 >> Launch an instance :
  Name: gabby-dev-consumer-private-ec2-1a
  Amazon linux: freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-consumer-lb-key-pair

  Network settings >>
    vpc: gabby-dev-vpc
    subnet: gabby-dev-consumer-private-subnet-1a
    Auto-assign public IP: Disable ****
    create security group name: gabby-dev-consumer-private-ec2-sg
      description: gabby-dev-consumer-pub-ec2-sg
    Inbound Security Group Rules:
      ssh: 22 

  Configure storage: 8 GB
  Number of instances: 1 >> Create instance

SSH INTO PULIC EC2 INSTANCE
==========================
chmod 400 gabb-dev-login.pem 
ssh -i gabb-dev-login.pem ec2-user@provider-pub-ipv4
*** ping google.com             - IT CONNECTS WITH GOOGLE.COM AS IT'S EXPOSED TO INTERNET ACCESS

 Once ssh into pub ec2 >> ssh into private ec2 from private
 =========================================================
 vi gabb-dev-login.pem copy & paste private key & save the file.
 chmod 400 gabb-dev-login.pem 
 ssh -i gabb-dev-login.pem ec2-user@provider-private-ipv4
*** ping google.com             - IT CAN'T CONNECT WITH GOOGLE.COM AS IT IS RESTRICTED INTERNET ACCESS

6. VPC END POINT SHOULD BE CREATED ON ""CONSUMER"" PRIVATE EC2 USING VPC END POINT SERVICE NAME FROM ""PROVIDER "" 
===========================
CREATE VPC END POINT
======================
AWS >> VPC >> END POINTS >> CREATE END POINTS :
Endpoint settings:
  name: gabby-dev-consumer-vpc-endpoint
  Service category: Other endpoint services ()
   aws >> vpc >> vpc end point services >> click: vpc end point service name >>
    copy service name: com.amazonaws.vpce.ap-south-1.vpce-svc-01e90662dde530ebb 
    >> verify
  VPC: gabby-dev-consumer-vpc
  Subnets: ap-south-1a (aps1-az1) 
  subnet id: gabby-dev-consumer-private-subnet-1a
  IP address type: ipv4
  security group: ssh & http: anywhere ipv4 >> create end point


  ***** VPC END POINT WILL SEND REQUEST TO """VPC END POINT SERVICES""" TO ACCEPT THE CONNECTION

ACCEPT VPC ENDPOINT REQUEST FROM VPC END POINT SERVICES:
====================
  AWS >> VPC >> VPC END POINT SERVICES >> CLICK END POINT SERVICE NAME: >>
   END POINT CONNECTIONS TAB >> 
     CHECK: END POINT ID >> ACTIONS >> ACCEPT END POINT REQUEST >> ACCEPT

ACCESS PROVIDER CONSUMER PRIVATE INSTANCE TO CONSUMER PRIVATE INSTANCE
========================================================
AWS >> VPC >> END POINTS >> SELECT END POINT NAME: 
 COPY:  DNS NAME: vpce-09b854f8852b33d4f-wsqs5ul9.vpce-svc-01e90662dde530ebb.ap-south-1.vpce.amazonaws.com
  from consumer private instance >> 
    curl vpce-09b854f8852b33d4f-wsqs5ul9.vpce-svc-01e90662dde530ebb.ap-south-1.vpce.amazonaws.com
  >> now it displays welcome message as 
--------
<!DOCTYPE html>
<html>
<body>

<h1>This is the demo from vpc end point services: from provider private ec2</h1>

</body>
</html>
------------
