WHAT IS AWS ORGANISATION?
```
A service offered by AWS that lets you manage multiple AWS accounts under a single entity, called an organization. 
This simplifies administration and provides better control over your cloud resources.
    > Used to create diff env which don't affect another env
```
BENEFITS:
```
Centralized Management
Cost Management
Security and Compliance
Resource Sharing
```
HOW TO CREATE MULTIPLE ACCOUNTS
```
aws root account>>services >> aws organizations >>:
    check root >> actions >> create new >> Organization unit name:
        name: gabby-test-aws-account-OU >> Create Organizational unit

    check: gabby-test-aws-account-ou >> add an aws account >> Create an aws account
        AWS account name: gabby-test-aws-account
        Email address of the account's owner: devopsmails1@gmail.com
        >> Crate aws account 
```
gabby-test-aws-account WEB CONSOLE ACCESS
```
New browser or incogito mode:
    aws login: devopsmails1@gmail.com >> forgot password >>
        new password link will be sent to email:
            copy paste the link on web browser >> enter & confirm the new password>>
                sign with email & new password >> goes to new account console
```




 