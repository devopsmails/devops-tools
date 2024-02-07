o-doc:https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dynamic-secrets  

Dynamic Secrets: 
```
kv secrets -  where you had to put data into the store yourself
Dynamic Secrets - generated when they are accessed
    > Dynamic secrets do not exist until they are read, 
    > so there is no risk of someone stealing them or another client using the same secrets. 
    > Because Vault has built-in revocation mechanisms, dynamic secrets can be revoked immediately after use, minimizing the amount of time the secret existed.
```
pre-req:
```
AWS Account
```
###KV Secret engine enabled by default###


```
vault secrets enable -path=aws aws
    - Enables the AWS secrets engine
```
CONFIG AWS CREDS:
```
vault write aws/config/root \
> access_key=AKIAQ3EGPNVG7VVDQON7 \
> secret_key=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 \
> region=ap-south-1
```

CREATE IAM-ROLE FOR SERVICE WITH PERMISSIONS:
```
vault write aws/roles/my-role \
credential_type=iam_user \
policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1426528957000",
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
```

GENERATE THE SECRET
```
vault read aws/creds/my-role

output:
Key                Value
---                -----
lease_id           aws/creds/my-role/n1TP1wDudw7lIDX7c3WwYYHD
lease_duration     768h
lease_renewable    true
access_key         AKIAQ3EGPNVGQJ7QQ3N5
secret_key         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
security_token     <nil>

####we can verify in aws my-role user id created####
```
Key lease duration is 768H  
Revoke the secret
```
vault lease revoke aws/creds/my-role/n1TP1wDudw7lIDX7c3WwYYHD

####we can verify in aws my-role user id revoked####
```