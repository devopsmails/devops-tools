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
