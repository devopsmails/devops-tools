What is Argo cd CLI?

```
Argo cd CLI helps to acts as any other tools cli to perform actions through commands
```

01_Argo cd Cli Installation:
---------------------
o_docs: https://argo-cd.readthedocs.io/en/stable/cli_installation/

Download latest version:
----------
```
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/

argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```
argocd O_cmd: https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_login/

02_Cluster login(On Which cluster should deploy):
----------------
```
argocd login 51.20.9.206:8082 - Cluster pub ip & port 
y
Username: admin
Password: LwJU0zVlPH8wo724(argocd server namespace secrets)
```
03_Deploy/create an app using argocd cli:
-----------------------
O_docs: https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_app/

app_create:  
o_doc: https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_app_create/

```
example: take one example cmd and run
  argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --directory-recurse

UI:
--
we can check it & should press on synchonize button to enable synchronization

cli:
---
kubectl get application -n argocd       - Shows application name with status
```
