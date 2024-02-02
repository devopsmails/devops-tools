#https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#downloading-and-installing-jenkins#
sudo su
cd ~
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo  
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

#To download Extra Packages for Enterprise Linux#
sudo amazon-linux-extras install epel
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install java-11-amazon-corretto -y
sudo yum install jenkins -y

#to auto start after every boot
sudo systemctl enable jenkins
sudo systemctl start jenkins

java --version
javac --version

sudo systemctl status jenkins
sudo hostnamectl set-hostname JENKINS-SERVER
sudo systemctl reboot

