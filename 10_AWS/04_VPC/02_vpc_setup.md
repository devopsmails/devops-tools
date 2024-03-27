YT: https://youtu.be/FZPTL_kNvXc  


VPC(Isolated Cloud Resource) Creating:  
-- 

vpc dashboard >> vpc create >> vpc settings:   
Resources to create: VPC and more   
Name tag auto-generation: aws_prod   
IPv4 CIDR block: #10.0.0.0/16    
IPv6 CIDR block>:  
  check: No IPv6 CIDR block  
uncheck: Amazon-provided IPv6 CIDR block  
Tenancy: Default  
Number of Availability Zones: 2  
Number of public subnets: 2  
Number of private subnets: #2  
NAT gateways: 1 per AZ  
VPC endpoints: #none  
DNS options:   
  check: Enable DNS hostnames  
  check: Enable DNS resolution  
click: Create VPC  

------------
Auto Scalling(Should be on Private subnet):  
--  
What is Auto scalling?  

is a method used in cloud computing that dynamically adjusts the amount of computational resources in a server farm   
- typically measured by the number of active servers - automatically based on the load on the farm.  

Auto Scalling setup:  

EC2 Dash board >> Auto scalling >> Create Auto Scalling >>:  

Auto Scaling group name >> #gabby-prod-vpc    
Launch template:    
  link: Create a launch template    
    Launch template name: #gabby-prod-vpc     
    Template version description: #gabby-production-level    
    Application and OS Images: Ubuntu server 20.04 LTS server  
    Instance type: #t2.nano    
    Key pair: #key1  
    Firewall (security groups): Create security group    
    Security group name - required: #gabby-prod-vpc      
    VPC: #gabby-prod-vpc    
    Inbound Security Group Rules:    
      rule1:    
      Type: SSH  Port range: 22 source type: anywhere    
      rule2:   
      Type: custom TCP  Port range: 8000 source type: anywhere  
Click: Create Launch Template  

--------

Choose launch template or configuration  
Refresh the launch template:  
  choose the template: gabby-prod-vpc  
  click next: >>  
    Choose instance launch options:  
      Network: 
        VPC: gabby-prod-vpc  
        Availability Zones and subnets: select Private subnets 
        click: Next >>  
          Configure advanced options:  
            Load balancing:   
              check: No load balancer    
              No changes in others   
              click on Next >>  
                Configure group size and scaling policies  
                  Group size:   
                    Desired capacity: #2  
                    Minimum capacity: #1  
                    Maximum capacity: #4  
                  Scaling policies:  
                    check: Target tracking scaling policy  
                    Scaling policy name: #gabby-prod-vpc 
                    Metric type: Averate cpu utilization  
                    Target value: 70 % cpu  
                    click: Next >>  
                      Add notifications:  
                        click: Add notifications  
                          select SNS topic  
                          click: Next >>   
                            Add notifications:  
                              click: Next >>  
                                Add tags:  
                                  click: Next >>   
                                    Review   
                                    click: Create auto Scalling group  
            
  -------------
What is Bastian Host or Jump Server?  

A Bastion Host (or a jump server) is a dedicated computer used to access infrastructure resources and helps compartmentalize them. From a security perspective, a Bastion host is the only node in the network exposed for external access.    

Bastian Host setup?  
  
1.VPC CREATE
=============
AWS >> VPC >> Create VPC:
  VPC name: gabby-dev-vpc
  cidr: 10.0.0.0/16 >> Create VPC = 65256

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
    Name: gabby-dev-pub-subnet-rt
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
    

Deploying a basic application on Private subnets  
----
vi index.html
copy

<!DOCTYPE html>
<html>
<body>

<h1>My First Heading</h1>

<p>My first paragraph.</p>

</body>
</html>

paste 
:wq!
-----
python3 -m http.server 8000
(Launching web application on 8000)  
--------------  

Load Balancer Setup?  
-------------------

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
      
