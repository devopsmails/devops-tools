What is the config maps?  
=========================

Configs Maps helps to save non-sensitive info: DB port, DB Username  

ConfigMaps in Kubernetes are a way to store and manage non-sensitive configuration data.     
They are stored as key-value pairs, and can be used to configure Pods, Deployments, and other Kubernetes objects.     
ConfigMaps are useful for decoupling configuration data from container images, which makes applications more portable and easier to manage.    

Creating a ConfigMap:  
====================
type 1:  
======  
To create a ConfigMap, you can use the """kubectl create configmap""" command. For example,   
the following command creates a ConfigMap called """my-configmap""" with two key-value pairs:  

kubectl create configmap my-configmap --from-literal=key1=value1 --from-literal=key2=value2   
Type 2:   
========  
You can also create a ConfigMap from a file or directory of files.   
For example, the following command creates a ConfigMap called """my-configmap""" from the contents of the directory """/path/to/config/files:"""  

kubectl create configmap my-configmap --from-file=/path/to/config/files  
-----------------

minikube status  
minikube start     # if it was a minikube
kubectl get deploy
kubectl get cm     #cm short form for config maps
git remote -v
git clone https://github.com/iam-veeramalla/Docker-Zero-to-Hero.git
cd Docker-Zero-to-Hero/examples/python-web-app/

vi configmap.yml
---------------
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: test-cm
data:
  db-port: "3308"

-----------
```
kubectl apply -f configmap.yml
kubectl describe cm test-cm           #shows the values of cm


```
vi deployment.yml
================
apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-app
  labels:
    app: python-app-label
spec:
  replicas: 2
  selector:
    matchLabels:
      app: python-app-label
  template:
    metadata:
      labels:
        app: python-app-label
    spec:
      containers:
      - name: python-app-cont
        image: sureshdevops1/python-app:v1
        #### cofigmaps by using env variables ####
        #env:
        #- name: DB-PORT
        #  valueFrom:
        #    configMapKeyRef:
        #      name: test-cm
        #      key: db-port
      ##### cofigmaps by Using volum Mounts. To Use Volumes first need to create volumes  ####
        volumeMounts:
          - name: db-connection
            mountPath: /opt
        ports:
        - containerPort: 8000
      #### volumes creating ######
      volumes:
        - name: db-connection
          configMap:
            name: test-cm  
-----------------
```
kubectl apply -f  deployment.yml   
kubectl get pods -w   
kubectl exec -it #podname-python-app-55574d879b-5896m -- /bin/bash   
  > in the pod bash command line run for env: env | grep #name of env var      # shows the env var value    

**** Better using this  bcz if env chnages it doesn't update with pods too. But if it the path with volume mount then it updates  ***  
  >  in the pod bash command line run for path: cat /opt/db-port | more        

kubectl exec -it python-app-59d7cd69f9-47cnt -- cat /opt/db-port | more        # To check directly with going into pod

kubectl describe cm test-cm
