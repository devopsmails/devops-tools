What is Ansible?
```
Configuration management tool
```
```
Open-source automation platform: 
    It's freely available for anyone to use and contribute to.
Agentless: 
    It doesn't require installing any agents on managed nodes, making it lightweight and easy to deploy.
Uses SSH for communication: 
    It connects to remote machines using Secure Shell (SSH) for secure communication.
YAML-based playbooks: 
    It defines automation tasks in simple, human-readable YAML files called playbooks.
Modules for specific tasks: 
    It has a vast library of modules that handle various tasks, from installing packages to managing cloud resources.
Idempotent: 
    It ensures tasks produce the same results every time they run, leading to predictable and consistent outcomes.
```

Why ansible tool in Devops?

```
Ansible automates IT tasks like configuration management, application deployment, provisioning, orchestration, and security, making DevOps processes faster, more reliable, and scalable.

Version upgrades
Pacakge installations
Security patches
Can write own modules(Python)
```

```
Ansible                          vs              puppet
==========================================================

push                             -                pull
Effective linux (ssh) & 
          windows(winrm)         -            Less effective
Agent less                       -            Master & Slave
Simple YAML                      -            New Puppet lang
==========================================================
```

01_Ansible installation:
---------------------
```
aws>> ec2> launch instances>> ubuntu >> number of instances-2(one Ansible & Terget server) Basic deatils:
Connect with instance
sudo apt update -y
sudo apt install ansible -y #******only on ansbile server
try:
ssh Privateip(Which does not authenticate)
```

02_Enable Password less auth between 2 servers:
---------------
Ansible & Target servers
```
ssh-keygen >> Enter & Enter

pwd location: home/ubuntu/.ssh

```
on Asnible server:
----------------
```
cat /home/ubuntu/.ssh/id_rsa.pub (copy the public key )
ex pub Key:
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhbFXkbk1qVyg2rJrm8BNVKvCQyWhYYECXfG+Hh74X9CBd3BUZzKqFYoC6UQi6IvUVL1rvR9PvoUUGN+8Nq8VcyIcCa4XU/njkpQjwoe2k+XU3RGMsaiDkM3dQCnE+GbyCKTR/4YP9gxR+KdtF0Yaq5klOiIsWgex9UDPhgZEgx3Nax6A60norWZmCUHTXxWJOMlIjwKNjk4tGrr/pz8KyZDBUyrvw1JPWA2V2Sqh5fAMdFgcLcQrDn560LVVCtlTZW51NUEa9Ud7KkSdXPgZhyz1LuIj88bahSDGpmcgrz6hTKhUuxWzj6d59/mruf51V/7oOU7/W904t0HBpP4p9wqs9ngBl/iK52tYXhy+w+IeDxqXi/guVv5AdxsVXmPomh87r/CLw4jKnQaKWJTQp8emaC+Tpzm81f+ea9ZywxHrAcXiEfBQLzPpugHRUbq7aTrX8g4plRTLQjk8tDwbJVCESNgSPinq1ahuaHmGBF5UTX9kTvmopnwQXLmBDYQ8= ubuntu@ip-172-31-40-108
```
on Target server:
---------------
```
cd /home/ubuntu/.ssh/
ls
vi authvi authorized_keys
(take one line gap if any other keys are there and paste ansible id_rsa.pub key and save)

```
on ansbile :
-----------
```
ssh 172.31.22.76(target Private ip)|
yes
Then it ssh into tartget server
exit
vi inventory (paste target private ip)

[web_servers]
172.31.22.76

[db_servers]
172.31.22.78
```

Diff b/w Ansible Ad-hoc commands vs playbooks:
------------------------
```
Adhoc   - To execute single cli commands
playbooks - to execute liste of cli commands
```
