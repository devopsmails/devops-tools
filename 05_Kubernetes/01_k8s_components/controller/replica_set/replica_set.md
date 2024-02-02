What is replica set?  
---------------------


A ReplicaSet is a Kubernetes object that ensures that a specified number of identical pods are running at any given time.  
It is often used to guarantee the availability of a specified number of identical pods.  
A ReplicaSet works by creating new pods as needed to reach the desired number of replicas.  
ReplicaSets are useful for running applications that need to be highly available, such as web servers and database servers.    


```
kubectl create replicaset my-replica-set --replicas=3 --image=nginx  
kubectl get replicaset  
kubectl get replicaset my-replica-set  
kubectl scale replicaset my-replica-set --replicas=5

replicaset.yml
---------------

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replica-set
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx:latest
-------------------
kubectl apply -f my-replica-set.yaml
```
