Helm CLI commands:

```
helm create helloworld          - creates 1st helloworld helm chart directory
tree helloworld
ls -lart                        - Shows helloworld helm chart is created
cd helloworld/                  - 
ls
cd templates/                   
ls                              - shows the list of yaml files using for this hello world helm chart

Change service port to NodePort:  

vi values.yaml:
---------
change:
service:
  type: NodePort ###
  port: 80 >> save
------
cd ..                                       - should be at same dir path to execute the install cmd
helm install myhelloworld helloword         - myhelloworld=helmchartname, helloworld=helmchart dir
                                              This command deploy on k8 cluster with the name myhelloworld

helm list -a                                - list helm charts deployed on k8 cluster
-----------
kubectl get service                         - shows the myhelloworld sevice up on nodeport on #port
                                              Ex: myhelloworld   NodePort    10.152.183.217   <none>        80:32332/TCP   3m46s

open security group 32332
WEB BROWSER:
    pub IP: 32332                   - We can access our deployment on website


```
K8's Dash board pre-requisites:
```
any k8's cluster(eks, gke, minikube, microk8s, kops) 
```
Dash board proxy enale:
```
microk8s dashboard-proxy        - microk8s= any k8s cluster name ex: minikube or kops ..
                                  dashboard-proxy = Enables dashboard proxy
                                  Once creation:
                                  --------
                                  copy 
                                  port: number
                                  token:
                                        eyJhbGciOiJSUzI1NiIsImtpZCI6ImpackttTExMMVJaeFBiUmVidTlTUDNnYmxPRXNKOU4wcnpzaFJrNXhGT2sifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtaWNyb2s4cy1kYXNoYm9hcmQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImNmMzMyMzE2LTdjMDgtNDhmMC1iZWQ1LTQyNjExOGZkYmNjYSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZWZhdWx0In0.SJ1cLD5KnMIl0Y34BTC5gWCM-L9n2zbetcsYhM9rQapyFs0tsMSQO1YqIDSt9q44P-AngQQlA2So_p2mrJnb1aYOWIspFxbu0cbc2k61DMvABo_2fpdooZZQ9d2dQ3FFZUc9xFLR7Zjcm6tGRIPWfUlyJblEgRt0OGafurbIxjsudwdtjvaLbdmD0gGN4cRcr8iBBua5YTE91ZsPqgltUUHdPnAf0T-ZuVjUesIHooEsxVnRDJKDkT0kAtladzNmnI7hrOV0_EcQrttZLEGjTk9P-cR4PYQ4W5oTm7bosn7KLNouFok9o7c1mHDNpSHwCAvbTt1T9xtXzXez4CVPkA

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
********We can now see on k8's dashboard myhelloworld deployment under deployment sction**********

helm list -a                                - Can see helm charts deployments 

helm create helloworld
***********Finding errors***********
helm lint helloworld    - Shows errors if there are any in helmchart

helm template helloworld
  > it directly communicate only with YAML files shows values renderd in it for debugging

helm install myhelloworldrelease --debug --dry-run helloworld   
  > Helps preview the chages before it heppens for prevent errors
  > It communicate with API-SERVER --> helloworld yaml files & provides response 
*****
helm install myhelloworldrelease helloworld
helm list -a           - Here we can see revision as 1

vi helloworld/values.yaml
  > change replicas: 2

helm upgrade myhelloworldrelease helloworld     - Upgrades the revision to 2 & changes will be live
helm list -a

helm rollback myhelloworldrelease 1             - 1=Revision number which we want to rollback to
                                                  The changes we can see on k8's dashboard as well
helm list -a                                    - Revision will be 3(as changes happens revision  
                                                  count increases)

helm uninstall myhelloworldrelease              - Successfully uninstall the myhelloworld deployment
    > We can now see myhelloworld deployment dissppearing on k8's dashboard deployments

```
CREATE OWN CUSTOM HELM CHART
```
git clone https://github.com/rahulwagh/python-flask-rest-api-project.git    - project repo
tree python-flask-rest-api-project

sudo apt install docker.io -y               - if not installed
sudo chmod 777 /var/run/docker.sock         - if not done
docker --version
docker login
  > with docker hub username & pwd
cd python-flask-rest-api-project/
docker ps                                   - check if container is running
docker images      

docker build -t python-project .            - builing docker iamge python-project
docker run -p 9001:9001 python-project      - enable sg 9001 & test access with pubip:9001 on web
docker tag python-project  sureshdevops1/python-flask-rest-api-project:python-project
  > on docker hub account(sureshdevops1) repo (python-flask-rest-api-project) should be created
docker push sureshdevops1/python-flask-rest-api-project:python-project

helm create python-project        
cd python-project
vi Chart.yaml
----------
#appVersion: "1.16.0"  - comment(#) >> save
--------

vi values.yaml
----
image:
  repository: sureshdevops1/python-flask-rest-api-project:python-project  ******
service:
  type: NodePort *********
  port: 9001 *********

 #livenessProbe: *******comment the whole with #
  #httpGet:
  # path: /
  #  port: http
  #readinessProbe:
  #httpGet:
  #  path: /
  #  port: http> *******save
---------

vi templates/deployment.yaml
---------
 image: "{{ .Values.image.repository }}" ******remove the rest close with ".
-------

helm lint python-project
helm install mypython-project-release --dry-run --debug python-project
helm template python-project
helm install my-python-project-release1 python-project

kubectl get pods
kubectl get deployments
kubectl get svc         - enable svc port on ec2 sg
  > Then access on web pubip:31175/hello

``` 

