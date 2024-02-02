What is Bastian Host or Jump Server?  

A Bastion Host (or a jump server) is a dedicated computer used to access infrastructure resources and helps compartmentalize them. From a security perspective, a Bastion host is the only node in the network exposed for external access.    

Bastian Host setup?  
  
EC2 Dash Board >> Create instance >>   
> name: Bastian Host  
  ami: ubuntu  
  instance type: t2.micro  
  key pair: #key1  
  netowrk:  
  > VPC:#gabby-prod-vpc   
    auto assign public IP: enable  
    create new SG Group:   
      check: ssh(must)
click: Launch instance  
