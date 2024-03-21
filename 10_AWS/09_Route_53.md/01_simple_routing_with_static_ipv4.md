WHAT ROUTE 53?
```
Amazon Route 53 is a highly scalable and reliable Domain Name System (DNS) web service provided by Amazon Web Services (AWS). 
It's designed to route end users to internet applications by translating domain names like """www.example.com""" into IP addresses that computers use to connect to each other. 
```
Benefits:
=======
```
High Availability and Reliability
DNS Management: 
    Route 53 allows you to register domain names, manage DNS records (such as A, AAAA, CNAME, MX, TXT records), and configure DNS routing policies easily through its web interface or API. This makes it easy to set up and manage complex DNS configurations.
Traffic Management:
    to control how traffic is routed to different endpoints based on various factors such as geographic location, latency, health checks, and weighted routing. 
Integration with AWS Services:
    Amazon S3, Elastic Load Balancing, EC2 instances, and CloudFront CDN
Global Reach
DNS Security : protect against DNS spoofing and other types of DNS-related attacks
Cost-Effective: Pay-as-you-go
```
USEFUL TERMINOLOGY:
==================
```
A Record:

An A record is the most common record type. It maps a hostname (subdomain) to an IP address. When a user enters your domain name in their browser, Route 53 uses A records to direct them to the server hosting your website or application.

NS:

"NS" stands for "Name Server" records. 
NS records are DNS records that specify the authoritative name servers for a particular domain. 
When someone accesses a domain name (e.g., example.com), their DNS resolver needs to know which name servers to query for information about that domain.
```
HOSTED ZONES:
==========
```
A hosted zone is a container for the DNS records that define how internet traffic is routed for a specific domain or subdomain. 
Essentially, a hosted zone is where you manage the DNS records for your domain.
```
IMAGE:
```
                                                     ===============aws============
USER >> www.sridharmaya.com >>godaddy or freedomaini >> route53 ns >> A record >> ec2
                                                     ===============aws============
```
CREATE A HOSTED ZONE
```
aws >> Route 53 >> Hosted zones >> Create Hosted zones: 
    name: sridharmaya.com
    Type: Public hosted zone >> Create hosted zone
        Creates sridharmaya.com NS & SOA
            ns-1551.awsdns-01.co.uk.
            ns-1377.awsdns-44.org.
            ns-933.awsdns-52.net.
            ns-304.awsdns-38.com.
```
Register a free Domain
=================
```
free domain registration for 1 year at freedomaini.com
sridharmaya.com >> Search: add >> Checkout:
copy & paste hosted zone name servers in custom nameserver:
            ns-1551.awsdns-01.co.uk.
            ns-1377.awsdns-44.org.
            ns-933.awsdns-52.net.
            ns-304.awsdns-38.com.
            >> signup or login >> place order & confirm order >> Client details.

```

CREATE AN EC2 WITH RUNNING APACHE2 SERVER
=========================================
```
AWS >> EC2 >> Launch an instance :
  Name: Route53-ec2
  Ubuntu: 24.04 freetier
  Instance type : t2.micro
  Key pair: create kay pair >> gabby-dev-key-pair

  Network settings >>
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

*** once the instance status checks are passed >> ipv4 ip on browser we can get private ip on web page
```
CREATING A-RECORD FOR sridharmaya.com USING """SIMPLE ROUTING POLICY"""
(A-RECORD = ROUTING TRAFIC TO AWS EC2 IPV4 IP)
====================
```
AWS >> Route 53 >> Hosted zones >>  sridharmaya.com >> Create record >>
Quick create record:
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Value: ec2 pub ip: 43.205.143.213
    TTL Seconds: 10(quick testing)
    Routing policy: Simple routing >> Create Record >> Show status >>

```
*** Issues & Best practices with simple routing
1. When EC2 instance is changed or restarted. It'll not route the trafic as it's connected with """Static ip address"""
2. Best practice is to use """Load Balancer"""
3. No hard coding ip address
```
