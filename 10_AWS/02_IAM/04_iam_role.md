DIFF B/W IAM ROLE VS IAM USERS
```
IAM roles and IAM users are both entities used for managing access to AWS resources, but they serve different purposes and have distinct characteristics. 

IAM Roles: 
    IAM roles are meant to delegate access to AWS resources to trusted entities, such as applications,  
    services, or other AWS accounts. They are temporary credentials assumed by entities when needed.

    Roles are assumed by entities through temporary security credentials. They don't have permanent
    credentials associated with them.

    used for cross-account access, federated access (integrating with external identity providers), EC2 instance profiles, and granting permissions to AWS services.

IAM Users: 
    IAM users represent individual identities (humans or machines) within your AWS account. They are permanent and can directly interact with AWS services.

    Users have permanent credentials (such as access keys, passwords, or MFA devices) associated with them for authentication.
    
    Users are typically used for granting access to individuals or services within the same AWS account.