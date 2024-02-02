 cluster ip (default service):  
 -----------------
 vi deployment.yml
 -----------
 ```
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
```
kubectl get pods 
minikube ssh
curl http://podip:8000#targetport/demo#anyroute
curl -L http://podip:8000#targetport/demo#anyroute #routing

node port service:
------------------
vi python-service.yml
```

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app: python-app-label
  ports:
    - port: 80
      targetPort: 8000
      nodePort: 30007
```


kubectl apply -f python-service.yml 
kubectl get svc -v=9
kubectl get svc

cluster ip:  
--------
ssh minikube ##### we can access through cluster ip #####
curl -L http://#Nodeportip10.98.80.20:80/demo  

Nodeport:
----------
minikube ip #ip of laptop which is accessing to the nodes
kubectl get svc
curl -L http://#minikubeip192.168.49.2:map30007/demo 

Check on the broswer with http://#pcip192.168.49.2:map30007/demo 

Load balancer:
-------------
kubectl edit svc python-service
/nodeport -searching in vi editor
kubectl get svc # svc will pending if its running on minikube # else it creates elastic ip address.
<img width="534" alt="image" src="https://github.com/devopsmails/devops/assets/119680288/9caf44b9-fbc4-43eb-a657-5079d2962975">  
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
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

---

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```
