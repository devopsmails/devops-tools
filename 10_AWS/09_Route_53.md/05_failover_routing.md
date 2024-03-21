What is Failover routing?

```
Failover routing is a technique used to ensure high availability and redundancy for your resources. 
It essentially creates a backup plan for traffic flow in case your primary resource becomes unavailable.
```
Benefits:
```
High Availability
Improved Disaster Recovery
Enhanced Resilience
Reduced Downtime Costs

```
weighted Routing image:
```
                                                     ===============aws============
                                                     >> route53 ns >> A record (PRIMARY) >> Load balencers1 >> ec2s(10.0.0.0/16)
USER >> www.sridharmaya.com >>godaddy or freedomaini 
                                                     >> route53 ns >> A record(Secondary) >> Load balencers2 >> ec2s(11.0.0.0/16)
                                                     ===============aws============
```
Loadbalancer 1 & 2 setup
========================
```
**** Instructions are same from 1 - 7 points from weighted_Routing.md **** 
**** After this 8 th point should be followed ****
```
8.CREATE A-RECORD USING AWS ROUTE-53 FAILOVER ROUTING & ATTCHED WITH 2 LOAD BALANCER
=========================================================
```
AWS >> Route 53 >> Hosted zones >>  sridharmaya.com >> Create record >>
Quick create record:
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-294273890.ap-south-1.elb.amazonaws.com/

    Routing policy: Fail over
       Failover record type: Primary 
       Record ID: Failover primary -lb2>> add another Record  >>
    
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-vpc2-294273890.ap-south-1.elb.amazonaws.com/

    Routing policy: Fail over
       Failover record type: Secondary 
       Record ID: Failover Secondary-lb2 >>  >> Create Record >> Show status >>
    
**** Once the status is """INSYNC""" 

*** Copy the DNS name(sridharmaya.com) on browser & we can see it shows the private ip of the 2 ec2 instances.
*** Stop Primary instance. search DNS name(sridharmaya.com) on browser & we can see it routes the trafic to secondary ec2.
```