What is namespace limit?   
------------------  

There is no limit on the number of namespaces you can create in Kubernetes.    
However, there are some practical limits that you should be aware of.    

Hardware resources:   
-----------------
Each namespace will consume some hardware resources, such as CPU, memory, and storage.   
If you create too many namespaces, you may run out of resources.  

Management overhead:    
-------------------  
Managing a large number of namespaces can be complex and time-consuming.  
You need to make sure that each namespace has the resources it needs and that it is properly configured.  

```
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace

---

apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  namespace: my-namespace
spec:
  containers:
  - name: my-container
    image: nginx:latest

---

apiVersion: v1
kind: Service
metadata:
  name: my-service
  namespace: my-namespace
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

---

apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-resource-quota
  namespace: my-namespace
spec:
  hard:
    cpu: "1"
    memory: 1Gi
    pods: "10"
```
