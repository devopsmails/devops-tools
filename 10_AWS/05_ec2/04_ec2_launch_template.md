WHAT IS EC2 LAUNCH TEMPLATE?
============================
```
An EC2 Launch Template in AWS is a blueprint that defines the configuration for launching EC2 instances. 
EC2 CONFIG:
    AMI
    INSTANCE TYPE
    VPC
    STORAGE
    KEY PAIR
    SG ..

```
Why ec2-launch instances?
```
Only one time we create all ec2 config manually by creating launch template with the name. 
when need to create ec2, ""we just can select the template"" get in all predefined config to create new instance.
Launch template reduce the key in each configuration each time to create an instance.

Benefits?
=========
Consistency and Reusability
Versioning and Flexibility
Advanced Features and Integrations
```
1.How to create ec2-instance launch template?
```
aws >> ec2 >> launch template >> Create Launch Template:
    Launch template name: gabby-dev-with-docker-apache2-launchtemp
    description: Ec2 will have docker & apache2 
    app OS: UBUNTU:22.04 archtecture: 64bit-x86
    Instance type: t2.micro
    Key pair: create new key >> aws_login_key.pem
    Network settings: 
        select VPC, SUBNET, SG, 
    Advanced settings:
        user data:
            ###############
            #install apache2
            ###############
            sudo apt update -y
            sudo apt upgrade -y
            ###################
            # install docker
            #####################
            sudo apt update -y
            sudo apt upgrade -y
            sudo apt install docker.io -y
            sudo usermod -aG docker ubuntu
            sudo systemctl status docker
    EBS Volumes:
        SIZE: 8 >> Create launch template
```
Launch ec2 instance using launch templates:
=====================================
```
aws >> ec2 >> down arrow button after launhc instances button:
    Launch instance from template >>
        Choose a launch template:
            Source template: gabby-dev-with-docker-apache2-launchtemp
            review all config once agin >> launch instance
```
ssh into instance
```
docker --verion
take ip & searchc on web
```
2. HOW CREATE A NEW LAUNCH TEMPLATE USING ""EXISTING LAUNCH TEMPLATE""
==================================================================
```
AWS  >> ec2 >> launch template >> create launch template:
    name: gabby-dev-with-doc-launch-template
    description: server has only only docker
    source template: 
        select the template
        in advanced settings:
            remove apache2 installation commands >> review config once agile >> create launch template
```
ssh to instance
```
instance ip on browser will give you anything now
but docker --version  shows the docker version
```





