WHAT IS AWS USER DATA IN EC2 SETUP?
```

AWS user data allows you to customize and configure your EC2 instances at launch time.
It provides a way to inject scripts or configuration data that are executed by the instance as it boots up for the first time.

Uses?
Automating Initial Configuration
Setting Up Permissions and Access
Customizing the Boot Process
Dynamic Configuration
Improving Security
```
Copy the user data while ec2 setup?
======================
```
aws >> ec2 >> name:
              ami: ubuntu
              sg:
              access key:
              network:
              Storage:
              advanced settings:
                User data:
                    Choose a file: To upload a script file from local ""or"" 
                    copy paste the script directly in the empty space
```
If user data script failed:
======================
```
tail -3000 /var/log/cloud-init-output.log

```
If want to edit the user data
=============
```
Ec2 >> select ec2 >> actions >> instance settings >> edit user data:
    edit & save
```