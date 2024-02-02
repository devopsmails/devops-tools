TEXT:

YT: https://youtu.be/xY6Ic7Igzck?si=MyOh4yZNJPqZIBF4

Kubernets Services: 
-----------------
A Kubernetes service in layman's terms is a way to expose a group of pods to other pods and services in the cluster, or to external clients outside the cluster.

Imagine you have a website running in Kubernetes. You want to make sure that your website is accessible to everyone, both inside and outside of the cluster. To do this, you would create a service that exposes the pods running your website.

Clients can then access your website by connecting to the service's IP address. The service will then distribute traffic across the pods running your website. This ensures that your website is highly available and can handle even the heaviest traffic loads.
 
Why Services: 
------------

Load Balancing: 
  Trafic will route to one pod to another pods  

Services Discovery (Through Labels & Selectors):  
  When pod goes down, Using Auto healing creates a new Pod(Rs) but ip changes not possible to route trafic. So Labels is used.  
  
Expose to world: 
  Can't be provided  to user to access a new ip address after every auto-Healing. So will be provided with elastic ip of Load Balancer to access from anywhere.  

Service Types:  
------------
Cluster IP:
  Allows access only who has access to Kubenets Cluster.  - Inside cluster

Node port:  
  Allows access only who has the Node (server/Instance) access - Inside Organization

Load Balancer(With Cloud Provider Only possible):  
  To the whole outer world can be accessed.  




