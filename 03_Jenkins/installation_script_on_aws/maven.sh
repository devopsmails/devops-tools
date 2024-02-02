#https://maven.apache.org/download.cgi

sudo su
cd ~
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz
ll
tar -xvzf apache-maven-3.9.3-bin.tar.gz
mv apache-maven-3.9.3 maven
cd /opt/maven/bin
./mvn -v

#Eviornment variable setup(to mvn command to work & access from anywhere in the server)

sudo su
cd ~
ll -a
find / -name java-11* #copy(/usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.amzn2.0.1.x86_64)#
source .bash_profile
mvn --v

./ mvn path setup

M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.amzn2.0.1.x86_64

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
.\

./configuring maven to jenkins

install plugin:
  Maven Integration 
Jenkins Dashboard: Manage Jenkins >> tool configuration >>
Jdk:
====
add jadk >> name: java_11
            JAVA_HOME: /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.amzn2.0.1.x86_64
Maven:
=====
add Maven: name: maven
           MAVEN_HOME: /opt/maven
.\
