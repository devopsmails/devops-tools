YT: https://youtu.be/3YTU4EPjEh4?si=Ghdzrbwi-TaFm5ku    

Note:   
====
Default ingress will not installed in k8 cluster.  
 
Enterprise level Load balencers:  
=============================
NGINX & F5  ..  

Benefits of Enterprise Load balancers:  
====================================
TLS(SECURE)  
Ratio Based Load Balencing ( 3 request to 1 pod 7 requests another pod)  
Sticky session ( If 1 request goes to 1 pod all the request sholud go to same pod)  
Path based  
Host/domain based   
White Listing  
Black Listing  

To provide enterprise loadbalenecer benefits:  
----------------------------------------  
K8 created concept called ""ingress"". But there are number of enterprise loadbalencers are available difficult create a logic for each LB(LOAD balencer),   
Came with option called """ingress controller""" which need to be configured in k8.   

ingress controller can be set up using HELM charts or YAML manifests.  

User creates deploys ingress controller & Ingress resources.   

----------------------------
Installtion of ingress on minikube:  
==================================
Doc: https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/  

cmd:  
----
minikube addons enable ingress         - ingress is enabled/installed  
kubectl get pods -n ingress-nginx      - shows out if it's installed properly  


Why ingress is needed when Load Balancder service types exposes to outer world?  
---------------------------------------------

Load balancer service type:  
----------------- 

The LoadBalancer service type creates a load balancer that distributes traffic across all of the instances of your service.   
This is a good option if you need to expose your service to the public internet and you need a high-availability solution.  

However, the LoadBalancer service type is not available on all Kubernetes providers. Additionally, it can be expensive to create and maintain load balancers.  

Ingress  
---------

Ingress works by routing traffic from outside the cluster to services within the cluster. It provides a unified way to manage and route traffic to your applications,   
without having to manage services and load balancers manually.  

Ingress is a good option if you need to expose your services to the public internet, but you don't need a high-availability solution. Additionally,   
Ingress is available on all Kubernetes providers.  

Reasons to use Ingress instead of the LoadBalancer service type  

Ingress is available on all Kubernetes providers, while the LoadBalancer service type is not.  
Ingress is often cheaper to use than the LoadBalancer service type.  
Ingress provides a unified way to manage and route traffic to your applications, without having to manage services and load balancers manually.  
Here are some specific examples of when you might want to use Ingress instead of the LoadBalancer service type:  

You are running a Kubernetes cluster on a cloud provider that does not support the LoadBalancer service type.  
You are running a Kubernetes cluster on a cloud provider that charges for load balancers.  
You need to expose multiple services to the public internet, but you don't need a high-availability solution for all of them.  
You need to route traffic to your services based on complex rules, such as the host name, path, and HTTP method.  


Problems with K8's Load Balencer service type:  
=====================================
Simple load balencing like (Round robin ex 5 to pod,  5 to another pod)  
Expensive static public ip of cloud load balencer if using many microservices  



Ingress routing types:
========================  
Host based routing  
path Based routing  

```
Commnds:
=========
minikube start              #if instance was restated.
kubectl get pods
kubectl get svc
ls
cd Docker-Zero-to-Hero/examples/python-web-app/
ll
vi python-service.yml 
kubect apply -f python-service.yml 
kubectl get svc
minikube ip
curl -L http://#minikube ip192.168.49.2:30007/demo -v

minikube addons enable ingress
kubectl get pods -n ingress-nginx

kubectl get ing
kubectl get svc
vi ingress.yml
=============
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: python-ingress
spec:
  rules:
  - host: "sevabharath.com"
    http:
      paths:
      - pathType: Prefix
        path: "/free"
        backend:
          service:
            name: service1
            port:
              number: 80
==================================
kubectl apply -f ingress.yml 
kubectl get ing
kubectl get svc
kubectl get pods -A
kubectl logs ingress-nginx-controller-7799c6795f-whxv9 -n ingress-nginx        ## Check the log of pod # in namespace ingress-nginx
kubectl get ing
sudo vi /etc/hosts - hostip & sevabharath.com
ping sevabharath.com      it works for packets sending & receiving
```
