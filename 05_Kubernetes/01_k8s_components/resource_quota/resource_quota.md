What is ResourceQuota?  
------------------------  
ResourceQuota is a Kubernetes object that enables administrators to restrict cluster tenants' resource usage per namespace.     
Namespaces create virtual clusters within a physical Kubernetes cluster to help users avoid resource naming conflicts and manage capacity, among others.  
ResourceQuota works by defining hard limits on the amount of resources that can be consumed by all Pods in a namespace.  
These limits can be expressed in absolute terms (e.g., 100 GiB of memory) or as a percentage of the cluster's total resources (e.g., 20% of CPU).  

#### If a user tries to create a Pod that exceeds the ResourceQuota limits for the namespace, Kubernetes will reject the Pod. ####  

ResourceQuotas can be used to limit the following types of resources:  
--------------------------------------------------------
```
CPU
Memory
Ephemeral storage
Persistent volumes
Persistent volume claims
Pods
```
ResourceQuotas can also be used to limit the number of objects of a particular type that can be created in a namespace:  
-----------
```
number of Pods,  
Deployments,  
Services.
```
vi resourece_quota.yml 
-----------------
```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: object-counts
spec:
  hard:
    configmaps: "10"
    persistentvolumeclaims: "4"
    pods: "4"
    replicationcontrollers: "20"
    secrets: "10"
    services: "10"
    services.loadbalancers: "2"

kubectl get ns
kubectl create ns dev_ns
kubectl apply -f resource_quota.yml -n dev_ns

kubectl get quota -n dev_ns               
        #shows the used & unused % of quota in ns dev_ns
```
####all types quota in one single yml call can call them while creating priorityClassName: high/medium/low  #####
```
quota.yml
-------
apiVersion: v1
kind: List
items:
- apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: pods-high
  spec:
    hard:
      cpu: "1000"
      memory: 200Gi
      pods: "10"
    scopeSelector:
      matchExpressions:
      - operator : In
        scopeName: PriorityClass
        values: ["high"]
- apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: pods-medium
  spec:
    hard:
      cpu: "10"
      memory: 20Gi
      pods: "10"
    scopeSelector:
      matchExpressions:
      - operator : In
        scopeName: PriorityClass
        values: ["medium"]
- apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: pods-low
  spec:
    hard:
      cpu: "5"
      memory: 10Gi
      pods: "10"
    scopeSelector:
      matchExpressions:
      - operator : In
        scopeName: PriorityClass
        values: ["low"]

-----

kubectl apply -f quota.yml -n dev_ns  
kubectl get quota -n dev_ns  
        #lists the quota  
kubectl describe quota -n dev_ns     
      #helps for debugging

kubectl run pod-nginx2 --image=nginx -n dev_ns priorityClassName=low
      # running a pod using nginx image in ns dev_ns by using the resourcequota "''low"""
kubectl run pod-nginx1 --image=nginx -n dev-gabby priorityClassName=high  
kubectl get pods -n dev-gabby
```
