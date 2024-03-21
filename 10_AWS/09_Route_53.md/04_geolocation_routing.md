What is Geolocation Routing?
===========================
```
Geolocation routing is a technique used to direct users to different resources based on their geographic location. 
It leverages information like IP address to make an educated guess about a user's physical whereabouts.
```
Benefits:
```
Improved User Experience
Content Localization
Compliance with Regulations
```
weighted Routing image:
```
                                                     ===============aws============
                                                     >> route53 ns >> A record >> Load balencers1(INDIA) >> ec2s
USER >> www.sridharmaya.com >>godaddy or freedomaini 
                                                     >> route53 ns >> A record >> Load balencers2(Africa) >> ec2s
                                                     ===============aws============
```
Loadbalancer 1 & 2 setup:
```
**** Instructions are same from 1 - 7 points from weighted_Routing.md **** 
**** After this 8 th point should be followed ****
```
8.CREATE A-RECORD USING AWS ROUTE-53 Geolocation Routing & ATTCHED WITH 2 LOAD BALANCER
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

    Routing policy: Geo location
       Location: India >> add another Record  >>
    
    Record name: Empty(As we point main domain not the sub domain)
    Record type: A- Routes Traffic to an IPv4 address and some AWS resources
    Toggle Alias:
      Route traffic to: Alias to Application & Classic Load Balancer
      Choose Region: Choose Region Where Load Balancer is created 
                    (asia-pacific-mumbai)
      Choose Load Balancer: Choose Load Balancer DNS name: http://gabby-dev-alb-vpc2-294273890.ap-south-1.elb.amazonaws.com/

    Routing policy: Geo location
       Location: Africa >>  >> Create Record >> Show status >>
    
**** Once the status is """INSYNC""" 
**** Use nord vpn connect from Diff Geo locations
*** Copy the DNS name(sridharmaya.com) on browser & we can see it shows the private ip of the ec2 instance.
```
