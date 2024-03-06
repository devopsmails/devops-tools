YT: https://youtu.be/TtlKFgfN3PU

GH: https://github.com/iam-veeramalla/aws-devops-zero-to-hero/tree/main/day-5

NACL(Network Access Control List):
------------------------------
1ST Level of Security which is Prior to Security Groups.  
It works at subnet level and for thousands of instances in subnet we can setup at once.   
It can "deny" & "allow" ports.   
It first accepts the lowest level of Rule number.   

-----------------

YT:   https://youtu.be/TtlKFgfN3PU

GH:   https://github.com/iam-veeramalla/aws-devops-zero-to-hero/tree/main/day-5

Security Groups:
--------------

Works at instance level
Second level of security after NACL

Allow/deny 2 ways of traffic
-----------
Inbound Traffic:                                             
------------                                              
Default it'll not allow anything.                                 
If user want to access the instance or app                    
We can ONLY allow specific ip or specifc ports not possible for Denying.                   

Out bound Traffic:
---------------
Default it'll  allow every port ecept port 25(mail).

If instance or app wants access internet

We can allow spefici ip or specifc ports

