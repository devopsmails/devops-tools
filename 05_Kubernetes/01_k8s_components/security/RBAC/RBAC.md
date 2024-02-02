
RBAC = Role Based Access Control

2 Types of RBAC SUPPORT:
=====================
1. USER ACCESS & SERVICE ACCOUNTS:

   USER: 
  (ex: what level access should have for dev & QA team)  
   
  SERVICE ACCOUNTS: 
   EX: If a pod is created & connected with a Service. That service should have restrictions to access or delete or create to any secret files.   

2. Roles/CLUSTER ROLES:
     EX: like AWS IAM ROLES: What level of access a role should have on an account level or cluster level
   
4. ROLE BINDING/CLUSTER ROLE BINDING:
   Connects users / Services account with Roles / Cluster Roles. With out Binding users with Roles no use.

RBAC ARCHETECTURE:
=================

![image](https://github.com/devopsmails/devops/assets/119680288/f13ce63a-5232-46c2-8dd9-25f9885d6f62)



