doc: https://kubernetes.io/docs/concepts/workloads/pods/  


What is Pod?  
--------------  
A pod in Kubernetes is a collection of one or more containers and some shared resources for those containers.     
It is the smallest  deployable unit in Kubernetes.     
Pods are scheduled by Kubernetes to run on worker machines, and they are managed by Kubernetes to ensure that they are always running.   

 Key benefits of using pods in Kubernetes:  
 --------------------------------

Simplicity: Pods are a simple and easy way to deploy and manage containerized applications in Kubernetes.  

Scalability: Pods can be scaled up or down easily to meet the needs of your application.  

Reliability: Pods are managed by Kubernetes to ensure that they are always running.  

Portability: Pods can be deployed to any Kubernetes cluster, regardless of the underlying infrastructure.  

-------------------
vi pod.yml  

apiVersion: v1  
kind: Pod  
metadata:  
  name: nginx  
spec:  
  containers:  
  - name: nginx  
    image: nginx:1.14.2  
    ports:  
    - containerPort: 80  


pod commands:    
--------------
```
kubectl run nginx --image=nginx --namespace=my-namespace
kubectl create -f pod.yml   
kubectl get pods -o wide    
minikube ssh  # - To ssh into minikube   
(or)    
ssh -i ubuntu@Master/node ip address   
curl ip ###### displays the application #####    
```
Error debug:  
===========   
```
Kubectl describe pods #podname  
Kubectl logs #podname  
```
