what is AWS WAF?
===========
```
AWS WAF stands for AWS Web Application Firewall. 
It's a security service offered by AWS that helps protect your web applications from malicious attacks. 

It acts as a gatekeeper for your web applications, inspecting the incoming HTTP(S) traffic.
You define rules that specify how AWS WAF should handle different types of requests. 
These rules can be based on factors like IP address, specific words in the request, or patterns in the data being sent.
Based on the rules, AWS WAF can allow, block, or monitor suspicious requests.
```
WHY AWS WAF?
==========
```
Protects from Common Attacks
Blocks Malicious Bots
Improves Application Availability
Managed Rules

AWS WEB APP FIREWALL SETUP
=======================
```
region = stockholm
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

3.Create 2 Public subnets
===============================
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
      IPv4 VPC CIDR block: 10.0.2.0/24 >> create sub

4.Route Table Creation
=====================
vpc >> route tables >> Route table settings
    Name: gabby-dev-pub-subnet-rt
    VPC: gabby-dev-vpc-id >> create route table
      Subnets association>>edit subnet associations >>
        select 2 public subnet ids >> Save association
  
  Route table associate with IGW(route table should have internet access)
  =============================
  select route gabby-dev-pubsubnet-rt id>> route >>
    Destination: 0.0.0.0/0 (anyip range can acess)
    Target: igw >> gabby-dev-igw >> save changes

5.Create ec2 instances on public subnet 1a & 1b
=======================================
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
  Security groups: create new security group with vpc, ssh, http anywhere allowed select gabby-dev-pub-ec2-sg
  Listeners and routing:
    Protocol:http
    port: 8080
    select a target group: gabby-dev-alb-tg
  Review summary once again >> CREATE LOAD BALENCER 
  ***go to load balancer >> Wait for some time to complete provisioning & to become active
  *** select load balancer >> details >> copy : DNS name: gabby-dev-alb-294487175.ap-south-1.elb.amazonaws.com 

```
8.IP SETS:
======
logical ip or ports want to allow or block
```
aws >> awf >> ip sets


Create ip sets >> 
    IP set name: my-pc-ip
    Region: stockholm
    IP version: IPv4
    IP addresses: 117.192.85.59/32(should always be the range not only ip) 
    >> create ip set >>
```
9.Web application firewall configuration
===================================
```
aws >> waf >> web acls >> create web acl >>
    region: stockholm(though waf is applied glabally, configuring for stockholm 
        region) >> create web acl >>
    Resource type: Regional resources
    region: stockholm re-check
    Associated AWS resources: add aws resources >>
        Resource type: Application Load Balancer
        select : gabby-dev-alb >> add >> next >>
        Add rules and rule groups:
            add rules >> add my own rules & rule groups
                Rule type: IP set
                Rule:   
                    name: block-my-pc
                IP set: 
                    select: my-pc-ip
                    IP address to use as the originating address: Source IP address
                    Action: Block >> add rule >>
                
        Add rules and rule groups:
            select rule: block-my-pc
            Default web ACL action for requests that don't match any rules: Allow
            >>next>>
            Set rule priority: 
                select: block-my-pc >> next >>
            Configure metrics: default name >> next >> **create web acl**

**** after successful configuration
**** check: associate aws resources whether properly associated with alb or not
**** check: Rules - can check blocking ip name  ip address details

aws >>ec2>> loadbalencer >> dns name: search on web -response as 403 - forbidden= it's working perfectly by restricting the access for pc ip address

Make it accessable from my pc ip:
===========================
```
aws >> waf >> region: stockholm >> web acls >> select gabby-dev-waf-ec2:
    rules tab >> slect: block-my-pc >> edit >> Action: allow or captcha(for restrict bots access)>> Save rule >>
        Set rule priority >> slect: block-my-pc >> save 

*** Refresh same alb dns : once captcha challenge done & now allows the access shows the ip details on the screen

```






