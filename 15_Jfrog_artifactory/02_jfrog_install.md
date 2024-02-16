O-docs: https://jfrog.com/help/r/jfrog-installation-setup-documentation/installing-artifactory  

Jfrog requirements?
```

4-cpu 8 GB memory
sg: ssh -22, 8081,8082
```
INSTALLING JFROG ON EC2-UBUNTU:
```
O-DOC: https://jfrog.com/community/download-artifactory-oss/
artifactory oss >> Get code source >>  copy link address for latest version
sudo apt update -y
sudo apt upgrade -y
cd /opt
sudo wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/7.77.5/jfrog-artifactory-oss-7.77.5-linux.tar.gz

```