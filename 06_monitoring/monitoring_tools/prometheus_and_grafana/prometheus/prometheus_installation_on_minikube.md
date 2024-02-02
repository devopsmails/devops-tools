Why & What is Prometheus?  
------------------------

Prometheus is an open-source systems monitoring and alerting toolkit     
Prometheus is designed to be reliable, scalable, and easy to use.    
Prometheus collects metrics from monitored targets by scraping HTTP endpoints.   
It stores the collected metrics in a time series database, where they can be queried using PromQL, a powerful query language.   
Prometheus also provides a built-in alerting system that can be used to notify users of potential problems.  

Prometheus is a popular choice for monitoring cloud-native applications and microservices.   
It is also used to monitor infrastructure components such as servers, routers, and switches.   



minikube status  
minikube start  
kubectl get pods -A  

Install prometheus using Helm:  
-----------------------------
Add helm repo  
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts  
```
Update helm repo  
```
helm repo update  
```
Install helm
```
helm install prometheus prometheus-community/prometheus
```
Expose Prometheus Service
This is required to access prometheus-server using your browser.
```
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext
```
