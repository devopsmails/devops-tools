What is namespace?  
---------------------
It provides a way to isolate groups of resources within a single cluster.  
Namespaces are useful for organizing resources by project, team, or environment. 
Namespaces can be used to create a more secure and organized Kubernetes environment.   
For example, you could create a separate namespace for each production application, or you could create a separate namespace for each development team.  

Benefits of using namespaces in Kubernetes:
--------------------------------------

Isolation: Namespaces isolate resources from each other, which helps to prevent conflicts and accidental changes.  
Security: Namespaces can be used to create a more secure Kubernetes environment by restricting access to resources.  
Organization: Namespaces can be used to organize resources by project, team, or environment.  
```
kubectl create ns suresh-namespace
kubectl get ns
kubectl describe ns suresh-namespace
kubectl run nginx --image=nginx --namespace=my-namespace
