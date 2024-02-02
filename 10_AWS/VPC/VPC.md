
![vpc-example-private-subnets](https://github.com/devopsmails/devops/assets/119680288/a010d8bb-7ba3-40ab-9fbb-6207f195bff4)




YT: https://youtu.be/P8g7Z4NYk3Q

GH: https://github.com/iam-veeramalla/aws-devops-zero-to-hero/tree/main/day-4

VPC
___________________

What is VPC and why it is used?
---------------

Virtual private clouds can be configured to tighten down security at the highest level. 
For instance, an organization can create virtualized replicas of access control features usually employed by traditional 
data centers. Like data center security, a VPC can control access to resources by IP address.


A Virtual Private Cloud (VPC) is a logical isolation of your AWS resources within the public AWS cloud. It is a virtual network that you can use to launch AWS resources in a private and isolated environment.
________


The components of a VPC are:
============================

VPC CIDR block: 
--------------

This is the range of IP addresses that are available for your VPC.

Subnets:
---------

Subnets are smaller ranges of IP addresses within your VPC. You can create multiple subnets for different purposes, such as public-facing subnets and private subnets.

Route tables: 
-----------
Route tables control how traffic flows within your VPC. They define the routes that traffic takes to reach different destinations.

Internet gateways: 
-----------------
Internet gateways allow traffic to flow between your VPC and the public internet.

NAT gateways: 
------------
subnet level security
NAT gateways allow instances in private subnets to access the internet.

Security groups: 
-------------
EC2 level security
Security groups control inbound and outbound traffic for your instances.

Network Access Control Lists (ACLs): 
-----------------------------------
ACLs are similar to security groups, but they control traffic at the subnet level.
____

VPC Diagram:
--------------
                       +-------------------+
                       |    Internet       |
                       |    Gateway        |
                       +--------|----------+
                                |
                                |
                                | 0.0.0.0/0
                                |
                                |
                       +--------|----------+
                       |   Route Table    |
                       | (Public Subnet)  |
                       +--------|----------+
                                |
                                |
                       +--------|----------+
                       |   Security Group |
                       | (for ELB & Targets)|
                       +--------|----------+
                                |
                                |   +------------+
                                |   |    ELB     |
                                |   +-----|------+
                                |         |
                                |         |           +---------------+
                       +--------|---------|-----------|   Target 1    |
                       |   Public Subnet            |   +---------------+
                       +-----------------------------+
                                |
                       +-----------------------------+
                       |   Private Subnet            |
                       +--------|--------------------+
                                |
                       +-----------------------------+
                       |   Private Subnet            |
                       +--------|--------------------+
                                |
                       +-----------------------------+
                       |   Network ACL               |
                       +--------|--------------------+
                                |
                       +-----------------------------+
                       |   Security Group            |
                       |   (for Private Instances)   |
                       +-----------------------------+
                                |
                                |
                       +--------|--------------------+
                       |   Private Instance 1        |
                       +-----------------------------+
                                |
                       +-----------------------------+
                       |   Private Instance 2        |
                       +-----------------------------+


