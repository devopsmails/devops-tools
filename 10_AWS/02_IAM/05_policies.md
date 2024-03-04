What is AWS IAM POLICY?
```
An AWS policy, within the context of AWS Identity and Access Management (IAM), is a document written in JSON format that defines what actions users or roles are allowed to perform on AWS resources.  
```
TYPES OF POLICIES?
```
1.Inline policy
2.Custom policy
```
DIFF B/W Inline & Custom policy
```
Both inline policies and custom policies are used to define permissions within AWS IAM

Inline Policy:
===========

Attachment: 
    Attached directly to a single IAM identity (user or role).
Management: 
    Managed directly within the identity itself. When you delete the identity, the inline policy is deleted as well.
Use Cases:
    Granting specific permissions to a single user or role that are unique to that identity.
    Useful for scenarios where a user or role only needs a limited set of permissions.

Custom Policy:
=============

Attachment: 
    Can be attached to multiple IAM identities (users or roles).
Management: 
    Created and managed as a separate entity from any specific identity. You can attach the same custom policy to multiple identities.
Use Cases:
    Defining a reusable set of permissions that can be applied to multiple users or roles.
    Standardizing permissions across a group of users or roles with similar needs.
    Easier to manage and update permissions centrally without modifying individual identities.