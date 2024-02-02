What is Static Pods?  
--------------------
A static pod in Kubernetes is a pod that is not managed by the Kubernetes API server.   
It is created and managed directly by the kubelet daemon on a specific node.  
Static pods are useful for running applications that need to be always running, such as system daemons and monitoring agents.  

To create a static pod in Kubernetes, you can use the following steps:  
-----------------------------------

Create a pod manifest file in YAML or JSON format.  
Place the pod manifest file in the /etc/kubernetes/manifests directory on the node where you want to run the static pod.  
Restart the kubelet service.  
The kubelet service will automatically detect the pod manifest file and create the static pod.  

Here is an example of a pod manifest file for a static pod:  
---------------------
```
YAML
apiVersion: v1
kind: Pod
metadata:
  name: my-static-pod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80

----------------
sudo cp my-static-pod.yaml /etc/kubernetes/manifests    
sudo systemctl restart kubelet  
kubectl get pod my-static-pod  
kubectl logs my-static-pod  
```
