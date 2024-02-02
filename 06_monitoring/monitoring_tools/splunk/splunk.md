```
O-link: https://www.splunk.com/en_us/sign-up.html?redirecturl=https://www.splunk.com/
YT: https://youtu.be/njTY4tf7ajg?si=scaeCYTysr73W9jG
```
Create an AWS-EC2-UBUNTU-Instance:
-----------------------------
```
Make sure Jenkins is up and running.(Jenkins instalations: https://github.com/devopsmails/devops/new/main/Jenkins)
UN: Adminsuresh
pwd: Adminsuresh
```
-------------
aws-ec2-ubuntu-20.04:
--------------
```
N: splunk
ami: ubuntu:22.04
t2.medium
mem: 24 GB
PORTS: 8000
```
Splunk Download:  
------------
```
signin >>
products >> 
Free trails & Downloads >>
splunk Enterprise: Free Trail >>
linux >>
debian download >>
accept >>
Download via CMD LINE >>
Copy the command and paste it on ubuntu linux >>
```
Commands on splunk:
------------------
```
wget -O splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.1.1/linux/splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb"

sudo dpkg -i splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb

sudo /opt/splunk/bin/splunk enable boot-start

Enter continuosly till 100%
yes
admin username: adminsuresh
PWD: adminsuresh

sudo ufw allow openSSH
sudo ufw allow 8000
sudo ufw status
sudo ufw enable
sudo ufw status

sudo /opt/splunk/bin/splunk start

webbroswer:
PublicIP:8000
ENTER: USERNAME(adminsuresh) & PWD(adminsuresh)

wait: 1 minute
can see Splunk Dash Board

```
Splunk Dash Board:
-------------
Jenkins installation on spluck dashboard:  
```
click: apps >> Find more apps >>
Search: Jenkins >> will get: ""Splunk App for Jenkins"" >>
install >>
splunk enterprise login:
username: devopsmails1@gmail.com #(splunk enterprise login CREDS)
pwd: Devops@Devops1 #(splunk enterprise login CREDS) >>
Done >>
Click: Splunk Enterprise >> can see ""Splunk App for Jenkins"" added.
```
jenkins config:
---------
```
splunk Dash board >>
settings tab >>
Data >> Data Input >>
http Event Collector >>
Global settings tab >>
enabled >> uncheck: Enable SSL(for practice purpose) >>
port: same (8088) >>
save >>
------------
new token tab >>
name: Jenkins >>
next tab >>
Review tab >>
submit tab >>
search tab >> token would have been createed
----
settings tab >> 
Data >> Data Input >>
http Event Collector >> we can see the token created >>
```
Jenkins Dash Board:
------------------
```
manage jenkins >> 
plugins >>
avialble plugins tab >>
search: Splunk >>
install >>
--------------
manage jenkins >>
system >>
search: Splunk for Jenkins Configuration:
  check: enable
  HTTP Input Host: splunk only public ip: (54.241.148.105)no http or /
  HTTP Input Port: 8088(while creating on splunk token the port we enable to access)
  HTTP Input Token: Copy the token from >> splunk dashboard >> settings > data >> data input >> http event collector: copy the token(0f3031ef-d927-4c90-be86-fc26be593381)
  uncheck: SSL Enabled
  check: Send All Pipeline Console Logs
  Jenkins Master Hostname: Jenkins IP ONLY(54.219.51.47)
  ```
  on Splunk cli:
  -------------
  ```
  sudo ufw allow 8088
  sudo ufw status
  ```
jenkins continuation:  
----------------
```
apply >>
Test connection >>
result: """Splunk connection verified"""
```
Need to restart Jenkins & Splunk for Metrics collection:
------------------
```
Jenkins restart: sudo systemctl resart jenkins or Jenkins webbrowswer: http://18.144.9.120:8080/manage/"""restart""" & enter
splunk restart: splunk dash board >> settings >> system >> serve controls >> Restart splunk tab >> yes
```
On splunk dash board """if seen green check mark """ = splunk config with jenkins was set up perfect 
-----------

on Jenkins Dashboard:
---------------
create some builds like  build1, 2, 3 with few perfect pipeline & few with intentional errors. Once we complete the build we get the whole jenkins metrics on Splunk.  
Can check metrics on by clicking: """Splunk app for jenkins"""  
using this we can see complete jenkins build status like number of sucess & failed build by whom with time & date & with many more  
