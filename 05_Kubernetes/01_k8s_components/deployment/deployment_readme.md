YT:  https://youtu.be/lVKLkyuRWCY?si=UCQYXZdxXpp5LmiZ

Container vs pod vs deployment:  ?
--------------------------

depoyment vs replicaset:  ?
----------------------


Why Deployment?
------------

Auto Scalling  
Auto Healing  

Deployment Process:  
--------------
Deployment >> Replica Set(Controller) >> Disired Pods are running   


What is Controller?  
-----------------  
Controller Ensures the desired state is actual State    

Default Controllers( K8's Provide these controllers):  
---------------------------------------------
ReplicationController  
ReplicaSet  
Deployment  
Job  
CronJob  
DaemonSet  
StatefulSet  
Service  
EndpointSlice  
NamespaceController  
ServiceAccountController  

```
yaml
----
vi deployment.yml  

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment ##Depoyment name
  labels:
    app: nginx ## Label defining for the app
spec:
  replicas: 3  ## Replics set should always 3 pods running
  selector:
    matchLabels:
      app: nginx  ## if Label matches with defining label for the app
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80


pre  
Commands:  
---------
kubectl get pods                     # Only pods
kubectl get all                      # all pods
kubectl get all -A                   # All pods in all name spaces

******  deployment.yml - is created in the same folder in yml format ***

kubectl apply -f deployment.yml       # Creates deployment which means - Deployment, Replica Set, Labels, Pods
kubectl get pods  
ex:
NAME                               READY   STATUS    RESTARTS   AGE  
nginx-deployment-cbdccf466-7kw5h   1/1     Running   0          22s  

kubectl get deploy  
ex:  
NAME               READY   UP-TO-DATE   AVAILABLE   AGE  
nginx-deployment   3/3     3            3           88s  

kubectl get rs   
ex:  
NAME                         DESIRED   CURRENT   READY   AGE  
nginx-deployment-cbdccf466   3         3         3       95s  

kubectl get pods --show-labels  
ex: 
NAME                               READY   STATUS    RESTARTS   AGE     LABELS   
nginx-deployment-cbdccf466-4jgdk   1/1     Running   0          2m36s   app=nginx,pod-template-hash=cbdccf466   

On duplicate tab:  
kubectl get pods -w            # Shows the running status of pods  
ex:  
NAME                               READY   STATUS    RESTARTS   AGE  
nginx-deployment-cbdccf466-7kw5h   1/1     Running   0          58s  
nginx-deployment-cbdccf466-m2fxs   1/1     Running   0          58s  
nginx-deployment-cbdccf466-rpkkw   1/1     Running   0          58s  

On original tab:  

kubectl delete pod #nginx-deployment-cbdccf466-7kw5h 
ex:  
pod "nginx-deployment-cbdccf466-7kw5h" deleted  

On duplicate tab:   
NAME                               READY   STATUS    RESTARTS   AGE  
nginx-deployment-cbdccf466-7kw5h   1/1     Running   0          58s 
nginx-deployment-cbdccf466-m2fxs   1/1     Running   0          58s  
nginx-deployment-cbdccf466-rpkkw   1/1     Running   0          58s  
nginx-deployment-cbdccf466-7kw5h   1/1     Terminating   0          2m19s  
nginx-deployment-cbdccf466-4jgdk   0/1     Pending       0          0s  
nginx-deployment-cbdccf466-4jgdk   0/1     Pending       0          0s  
nginx-deployment-cbdccf466-4jgdk   0/1     ContainerCreating   0          0s  
nginx-deployment-cbdccf466-7kw5h   0/1     Terminating         0          2m20s  
nginx-deployment-cbdccf466-7kw5h   0/1     Terminating         0          2m21s  
nginx-deployment-cbdccf466-7kw5h   0/1     Terminating         0          2m21s  
nginx-deployment-cbdccf466-4jgdk   1/1     Running             0          1s          *** ensure disired state is actual state ***    pre

```
