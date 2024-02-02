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
            
  

