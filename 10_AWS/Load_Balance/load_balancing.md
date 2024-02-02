What is Load Balancing?  
---- 


Load balancing is a technique that distributes incoming traffic across multiple servers.  
This helps to improve the performance and reliability of a web application or other online service.  

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
