
What is Open shift? 
=======================
OpenShift is a container orchestration platform that builds on top of Kubernetes to provide additional features and functionality. 
  It is a commercial product from Red Hat, but there is also an open source version called """OpenShift Origin""".

Here is a point-wise summary of OpenShift:

Container orchestration: 
    OpenShift provides a managed environment for deploying and managing containers.
  
Web-based console: 
    OpenShift provides a web-based console that makes it easy to manage your cluster and applications.
  
CI/CD pipelines: 
    OpenShift integrates with CI/CD tools to make it easy to automate the build, test, and deployment of your applications.
  
Image registry: 
    OpenShift includes an image registry that you can use to store and manage your container images.
  
Security:
    OpenShift provides a number of security features to help you protect your applications.
OpenShift is a good choice for organizations that want to deploy and manage containerized applications at scale. 
  
  
It is also a good choice for organizations that want to take advantage of CI/CD pipelines and other DevOps tools.

Here are some of the benefits of using OpenShift:

Reduced complexity: 
    OpenShift can help you reduce the complexity of managing containerized applications.
  
Improved reliability: 
    OpenShift can help you improve the reliability of your applications by providing features such as load balancing and service discovery.
  
Increased agility:
    OpenShift can help you increase the agility of your development process by providing features such as CI/CD pipelines and rollbacks.
  
Enhanced security:
    OpenShift can help you enhance the security of your applications by providing features such as role-based access control and network security.
  
openshift (OC) CLI Installation on AWS EC2 UBUNTU:
==================================================
```
ssh -i your-key.pem ubuntu@ec2-instance-ip

# Download the oc binary (replace version with the desired version)
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.8.7/openshift-client-linux.tar.gz

# Extract the tar.gz file
tar -xzf openshift-client-linux.tar.gz

# Move the oc binary to a directory in your PATH (e.g., /usr/local/bin)
sudo mv oc /usr/local/bin

# Verify the installation
oc version

oc login # openshift console >> profile >> copy login id command >> display token >> copy paste here  
kubectl create deployment nginx-deployment --image=nginx  

On console >> Administrtor >> workload  >> pods: list the pods in running in that name of that login  

oc loogout   
```
