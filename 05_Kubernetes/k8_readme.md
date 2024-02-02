GH: 
YT: https://youtu.be/dfxrdoEQe00?si=vEeiBmD8gwHdysYs 
```
Containers:
----------

Containers are ephemeral(Short life) in nature

Issues with container only with Docker:                        K8's Solutions:
--------------------                                          ---------------
runs on Single hosts                           -           As K8 is installed on cluster (multiple nodes) containers will not go down for less resources.
Doesn't have Auto-scalling                     -           k8 has HPA(Horizental Pod Autoscaler) will increase the space or create new container for huge trafic.
No Auto Healing                                -           Auto Healing controls & fix the damage by creating a new pod/container with instruction API-server
No Enterprise level support
```

Cluster = Group of Nodes
```
K8's Archetecture:
-----------------
Master - K8 will be installed
Nodes -  Master will make use of nodes install pods as per requests.
```
     K8's
===================                                                                  
```
 Master Node / Control Plane  
=========================  
API-Server:
-------------
        core of the control plane, Takes the input from Out world work accordingly, and exposes to outer world.

Shedulor:
--------
        API-Server Decides to create pods on which free node & Schedulor executes
   
ETCD:
------
        Entire cluster data is saved in Key-value format.  It's kind of Back up Data Storage.  

Control Manager:
----------------
        By using Controllers like Replica set Make sures the disired state is the Actual sate

Cloud Controller Manager(CCM):
--------------------------------
         to make avail the K8 with diff public cloud provider need to go to CCM-GITHUB, Create a logic for their own usage k8 as a service: EKS, AKS, 
                                                                      


Worker node/Data Plane                                                                                          Docker  
===========                                                                                                ================
Kubelet:
-----------
       creates the pods & make sures the pod in running state,                     - To create containers: Docker Deamon

Container Run Time:
-------------------
        runs the containers using DIFF CRT like "Docker, Crio, rocket"..            - Docker Run time - "Dockerengine" = docker deamon
Kube-proxy:                                                  
-----------
        cares networkinG, create the IP address & Loadbalancing,                   - Networking: Bridge 
        Using linux IP Tables for networking.
```
