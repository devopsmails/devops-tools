if k8s dashboard not be accessable:
--------------------------------
```
microk8s dashboard-proxy        - microk8s= any k8s cluster name ex: minikube or kops ..
                                  dashboard-proxy = Enables dashboard proxy
                                  Once creation:
                                  --------
                                  copy 
                                  port: number
                                  token: key

Need enable that port sg inbound rule

if k8s dashboard not be accessable:
--------------------------------
kubectl get service -n kube-system          - Shows kubernetes-dashboard runnning on clusterip
ex: kubernetes-dashboard        ClusterIP   10.152.183.210   <none>        443/TCP               

kubectl edit svc kubernetes-dashboard -n kube-system    - Go to TYPE = **** change NodePort >> save
kubectl get svc -n kube-system              
    - We can see k8's dashboard runnin on NodePort at port: 31209 
    Ex: kubernetes-dashboard        NodePort    10.152.183.210   <none>        443:31209/TCP  
ec2-server sg port 31209 should be enabled 
web:
    publicip:31209
    Token: paste >> login >> We can see the K8's dash board
```

ErrImagePull
```

```
