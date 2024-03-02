Create IAM user enable console access:

```
aws >> IAM >> users >> create user:
    > add u.name as test-user >> next
    > attach to group >> create user

    > iam users >test_user:
        >Security creds >> Enable console acess:
            > custom password
            > gen new password at next login
            > enable it

inconginto window:
  > aws login:
    > root account id:
    > username: test-user
    > pwd:
    login >> aws console login
  s3 service:
  buckets: error permission denied because no persmissions were added

  ```
 Policy Creation:
 ==============
  ```

  aws root account >> policies >> create policy:
    > json:
        {
	"Version": "2012-10-17", 
	"Statement": [ 
		{
			"Sid": "gabby-dev-s3-allow",
			"Effect": "Allow",
			"Action": "s3:*",
			"Resource": "*"
		}
	]
    Version = Default version given by aws & must be followed
    Statement = This is an array containing one or more policy statements.
    sid = 
        "Statement ID." It's an optional, user-defined identifier for the statement,used mainly for clarity and reference within the policy.
    Effect = 
        This specifies the effect of the policy, which can be either "Allow" or "Deny". In this case, it's set to "Allow", meaning that the actions specified in this statement are permitted.
    Action = 
        This specifies the AWS actions that are allowed or denied by this statement. In this case, it's allowing all actions (*) within the Amazon S3 service. This includes all S3 API actions such as GetObject, PutObject, ListBuckets, etc.
    Resource = 
        This specifies the AWS resources to which the actions specified in the statement apply. In this case, it's set to "*", which means that the actions are allowed on any S3 resource. This effectively grants permission to perform any S3 action on any bucket or object within the AWS account.

    Next >>
    policyname: gabby-dev-s3-allow
    Create policy
```
attach  PERMISSION policy TO IAM USER
```
Root account: 
    > user: test-user >>
        > permission >> add permissions >> attach policy >> attach custom policy >> Search: gabby-dev-s3-allow >> Check >>
         Next >> policy is attached to test-user   
```
test-user account >> refresh >> error will be removed


