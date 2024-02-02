minikube cluster:
-----------------
Same devops repo >> kubernetes >> k8_installation >> minikube installation (Do as per written)

minikube status
-------------------
Argo CD installtion:
------------------

o_doc: https://argo-cd.readthedocs.io/en/stable/getting_started/

1.install Argo Cd:
---------------
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
```
kubectl get pods -n argocd -w
kubectl get svc -n argocd
kubectl edit svc argocd-server -n argocd
    > Change type: ClusterIP to NodePort >> save it
```

To Accesss argocd UI
```
minikube service list -n argocd
    > give list of servces avialble under name space argocd

create tunnel to access argo cd on browser
---------------
minikube service argocd-server -n argocd
    > Exposes argocd-server
    > If not accessable on web browser:
        > kubectl port-forward svc/argocd-server -n argocd --address 0.0.0.0 8089:443
        
UI:
Username: admin
password: 
    > Duplicate server: kubectl get secrets -n argocd
    output: 
    copy: argocd-initial-admin-secret
    copy: password: THdKVTB6VmxQSDh3bzcyNA==
    decode secrets:
        > echo THdKVTB6VmxQSDh3bzcyNA== | base64 --decode
        > copy: LwJU0zVlPH8wo724
password: LwJU0zVlPH8wo724 >> signin
```
02_config apps to argocd to deploy on minikube cluster for everychange with versioning
---------------------
```
argo cd dash board:
-------------
create app:
    > GENERAL:
        > Application Name: first_argo_cd_dev
        > Project Name: default
        > SYNC POLICY: Automatic
        > SOURCE:
            Repository URL: Git repo >> code >> https code: ex: https://github.com/devopsmails/argocd-example-apps.git
            Revision: HEAD
            Path: Deploymentfilepath ex: guestbook
        > DESTINATION: Cluster URL : ex: default minikube cluster
        > Namespace: ex: dev or pprod ( will wail until namespace is created to deploy)
        >> create

```
