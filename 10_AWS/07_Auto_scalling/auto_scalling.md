Auto Scalling(Should be on Private subnet):  
--  
What is Auto scalling?  

is a method used in cloud computing that dynamically adjusts the amount of computational resources in a server farm   
- typically measured by the number of active servers - automatically based on the load on the farm.  

AUTO SCALLING SET UP ON 2 PUBLIC SUBNETS
======================================
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
  select route gabby-dev-pub-subnet-rt id>> edit subnet association >>
    Available subnets:
      Select subnets 2 subnets: gabby-dev-pub-subnet-1a & 1b
  select route gabby-dev-pub-subnet-rt id>> route >> edit route ??
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes

5.CREATE EMPTY TARGET GROUP WITHOUT INSTANCES CREATED OR ATTACHED
===================================================
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
          Available instances: EMPTY >> Create target group >>

6.APPLICATION LOAD BALANCER CREATION
=====================================
AWS >> EC2 >> LOAD BALANCERS >> CREATE LOAD BALANCERS >> 
Compare and select load balancer type: Application Load Balancer >> Create
Create Application Load Balancer >>Basic configuration >>
  Load balancer name:  gabby-dev-alb 
  Scheme: Internet facing
  IP address type: IPv4
  Network mapping:
    VPC: select gabby-dev-vpc
    Mappings: select 2 subnets: gabby-dev-pub-subnet-1a & 1b

  Security groups: select gabby-dev-pub-ec2-sg 
  OR 
  CREATE SG >> 
    SG NAME: select gabby-dev-pub-ec2-sg, 
    SELECT VPC: gabby-dev-vpc
    ADD INBOUND RULES CREATE http: anywhere & create sg
  Listeners and routing:
    Protocol:http
    port: 8080
    select a target group: gabby-dev-alb-tg
  Review summary once again >> CREATE LOAD BALENCER 
*** Refresh till Load balancer provisioning is active



7.CREATE AUTO SCALLING
========================
AWS >> EC2 >> CREATE AUTO SCALE GROUP >> Auto Scaling group name:
  name: gabby-dev-asg
  Launch template:
    create Launch template: 
       CREATE LAUNCH TEMPLATE FOR AUTOSCALLING
       ====================================
aws >> ec2 >> launch template >> Create Launch Template:
    Launch template name: gabby-dev-with-docker-apache2-launchtemp
    description: Ec2 will have docker & apache2 
    app OS: UBUNTU:22.04 archtecture: 64bit-x86
    Instance type: t2.micro
    Key pair: create new key >> aws_login_key.pem
    Network settings: 
        select VPC, NO SUBNET SELECT, SG(HTTP:ANYWHERE, SSH: ANYWHRE), 
        Advanced network configuration:
          add network interface:
            Auto-assign public IP: Enable
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
    EBS Volumes:
        SIZE: 8 >> Create launch template
gabby-dev-with-docker-apache2-launchtemp >> next
    Network: 
      VPC: select   gabby-dev-vpc
      Availability Zones and subnets: select: ap-south-1a/1b >> next
  Load balancing:
    Attach to an existing load balancer:
      Attach to an existing load balancer
        Choose from your load balancer target groups:
          Existing load balancer target groups: select gabby-dev-alb-tg
    Health checks:
      select: Turn on Elastic Load Balancing health checks
      Health check grace periodInfo: 200 ***it should be based on app requirements
  Configure group size and scaling - optional:
    Group size: 
      Desired capacity: 2
      min: 1
      max: 3
  Automatic scaling: No scaling policies >> next 
  Notification: >> next
   >> Create auto scalling group >>

*** refresh untill providing capacity is gone
**** CHECK EC2 >> 2 INSTANCE are provided & running
*** load balancer >> copy DNS name: search on browser & refresh if it's load balance to another server as well
**** loadbalencing is equally distributing to both the servers then delete one server & wait for some time. So that auto scalling will create a server to match disered state.




```
```



```
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
```          
  

