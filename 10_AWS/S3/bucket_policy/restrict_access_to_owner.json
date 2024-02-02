GH:  https://github.com/iam-veeramalla/aws-devops-zero-to-hero/blob/main/day-9/demos/bucket-policies/restrict-access-to-owner.json  

{
  "Version": "2012-10-17",
  "Id": "RestrictBucketToIAMUsersOnly",
  "Statement": [
    {
      "Sid": "AllowOwnerOnlyAccess",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::your-bucket-name/*",
        "arn:aws:s3:::your-bucket-name"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalArn": "arn:aws:iam::AWS_ACCOUNT_ID:root"
        }
      }
    }
  ]
}


AWS_ACCOUNT_ID=ROOT ACCOUNT ID
