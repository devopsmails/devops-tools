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

```
* CREATE IAM USER WITHOUT ANY POLICY ATTACHED(user To assume role)  
* CREATE IAM ROLE
```
IAM >> Roles >> Create role:
    Trusted entity type: AWS ACCOUNT
    An AWS account: This account >> next
        Add permissions: s3 full access >> next
            Role details:
                name: gabby-dev-s3fa >> Create Role
```
ATTACHING IAM USER WITH ASSUME ROLE
```
IAM >> USERS>> #test-user >> add permissions >> inline policy:
    Specify permissions >> Json:
    {
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": "sts:AssumeRole", #get or put etc
			"Resource": "arn:aws:iam::891376921430:role/gabby-dev-s3fr-access" #role arn
		}
	]
}
    >> next >>
        Policy name: gabby-dev-s3f-ipolicy >> Create policy. 
```
```
* IF WE TRY TO access S3 WITH USER TEST-USER GIVES ERROR
* BUT IF ROLE LINK & PASTE ON A NEW TAB >> IT ASKS FOR TO ENTER NEW DISPLAY NAME
* ONCE WE ENTER >> CHECK S3 ACCESS WILL BE ABLE ACCESS IT WITH OUT ERRRO
* TOP RIGHT SIDE CORNER NAME ALSO CHANGES TO ROLE NAME @ ACCOUNT ID
```

HOW TO SWITCH BACH TO THE PREVIOUS STATE OF USER(WITHOUT ASSUIMING THE ROLE)
```
top right corner of the role >>  switch back >> 
    If we access s3 now with assuming role error occurs             
```
